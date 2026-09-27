#!/usr/bin/env bash
set -euo pipefail
cd "$(dirname "$0")"

ids_txt="ids.txt" # one entry per line: source:id (or url:https://...)
manifest="walls.json"

# metadata/API fetch: curl's native retry — transient errors only,
# exponential by default, honors Retry-After; 404s fail fast
meta() {
  curl -fsSL --connect-timeout 15 \
    --retry 5 --retry-delay 0 --retry-max-time 300 "$1"
}

# nix-prefetch-url has no retry; add manual exponential backoff
prefetch() {
  local url=$1 max=5 delay=1 n=1
  until sha=$(nix-prefetch-url --quiet "$url"); do
    (( n >= max )) && { echo "prefetch failed: $url" >&2; return 1; }
    sleep "$delay"; delay=$((delay * 2)); n=$((n + 1))
  done
  printf '%s' "$sha"
}

# sliding-window limiter: pace <max> <window_secs>
declare -a req_times=()
pace() {
  local max=$1 win=$2 now t
  while :; do
    now=$SECONDS
    # expire timestamps older than the window
    while (( ${#req_times[@]} > 0 )) && (( now - req_times[0] >= win )); do
      req_times=("${req_times[@]:1}")
    done
    (( ${#req_times[@]} < max )) && break
    # window full: sleep until the oldest request expires, then recheck
    t=$(( req_times[0] + win - now ))
    (( t > 0 )) && sleep "$t"
  done
  req_times+=("$SECONDS")
}


tmp=$(mktemp)
while IFS= read -r entry; do
  [[ -z "$entry" || "$entry" == \#* ]] && continue
  src="${entry%%:*}"
  id="${entry#*:}"

  case "$src" in
    wallhaven)
      pace 45 60
      url=$(meta "https://wallhaven.cc/api/v1/w/$id" | jq -r '.data.path')
      name="wh-${id}.${url##*.}"          # dot fixed
      ;;
    url)
      url="$id"
      name="direct-$(basename "$url")"
      ;;
    *) echo "unknown source: $src" >&2; exit 1 ;;
  esac

  sha=$(prefetch "$url")
  jq -nc --arg src "$src" --arg id "$id" --arg url "$url" \
         --arg name "$name" --arg sha "$sha" \
         '{source:$src, id:$id, url:$url, name:$name, sha256:$sha}' >> "$tmp"
done < "$ids_txt"

[[ -s "$tmp" ]] || { echo "no entries generated" >&2; rm -f "$tmp"; exit 1; }
jq -s 'unique_by(.sha256)' "$tmp" > "$manifest"
rm -f "$tmp"
echo "manifest: $(jq length "$manifest") entries"
