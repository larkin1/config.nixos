#!/usr/bin/env bash

set -euo pipefail

RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
CYAN='\033[0;36m'
BOLD='\033[1m'
DIM='\033[2m'
RESET='\033[0m'

ZSHRC="$HOME/.zshrc"
LINE='source "$HOME/.config/starship/init.zsh"'
SCRIPT_DIR="$(cd "$(dirname "$0")" && pwd)"

PROMPT_DEPS=(
    "starship|starship|prompt engine"
    "zsh|zsh|shell"
    "zsh-history-substring-search|zsh-history-substring-search|history substring search"
    "zsh-syntax-highlighting|zsh-syntax-highlighting|syntax coloring"
)

OPTIONAL_DEPS=(
    "eza|eza|modern ls replacement"
    "bat|bat|modern cat replacement"
    "zoxide|zoxide|smarter cd command"
)

PACMAN_PACKAGES=(
    "starship"
    "zsh"
    "zsh-history-substring-search"
    "zsh-syntax-highlighting"
    "eza"
    "bat"
    "zoxide"
)

check_cmd() { command -v "$1" &>/dev/null; }
check_plugin() { [[ -f "/usr/share/zsh/plugins/$1/$1.zsh" ]]; }

is_installed() {
    local name="$1"
    case "$name" in
        zsh-history-substring-search|zsh-syntax-highlighting) check_plugin "$name" ;;
        *) check_cmd "$name" ;;
    esac
}

ask_yesno() {
    local prompt="$1"
    while true; do
        echo -en "${prompt} ${DIM}[Y/n]${RESET} "
        read -r answer
        case "$answer" in
            ""|y|Y|yes|YES) return 0 ;;
            n|N|no|NO) return 1 ;;
            *) echo -e "${RED}please answer y or n${RESET}" ;;
        esac
    done
}

echo
echo -e "${CYAN}${BOLD}  ╔══════════════════════════════════════╗${RESET}"
echo -e "${CYAN}${BOLD}  ║${RESET}        ${BOLD}starship config setup${RESET}         ${CYAN}${BOLD}║${RESET}"
echo -e "${CYAN}${BOLD}  ╠══════════════════════════════════════╣${RESET}"
echo -e "${CYAN}${BOLD}  ║${RESET}   ${DIM}custom zsh config with starship${RESET}    ${CYAN}${BOLD}║${RESET}"
echo -e "${CYAN}${BOLD}  ║${RESET}      ${DIM}prompt, aliases, & plugins${RESET}      ${CYAN}${BOLD}║${RESET}"
echo -e "${CYAN}${BOLD}  ╚══════════════════════════════════════╝${RESET}"
echo

echo -e "${BOLD}this script will:${RESET}"
echo -e "  1. check for required and optional dependencies"
echo -e "  2. optionally install missing packages (arch linux)"
echo -e "  3. add ${CYAN}source \"$HOME/.config/starship/init.zsh\"${RESET} to ${DIM}~/.zshrc${RESET}"
echo

if ! ask_yesno "continue?"; then
    echo -e "${DIM}aborted.${RESET}"
    exit 0
fi
echo

declare -a missing_pkgs=()
declare -a installed_names=()

echo -e "${BOLD}required dependencies:${RESET}"
for entry in "${PROMPT_DEPS[@]}"; do
    IFS='|' read -r pkg name desc <<< "$entry"
    if is_installed "$name"; then
        echo -e "  ${GREEN}✓${RESET} $name — ${DIM}$desc${RESET}"
        installed_names+=("$name")
    else
        echo -e "  ${RED}✗${RESET} $name — ${DIM}$desc${RESET}"
        missing_pkgs+=("$pkg")
    fi
done

echo
echo -e "${BOLD}optional dependencies:${RESET}"
for entry in "${OPTIONAL_DEPS[@]}"; do
    IFS='|' read -r pkg name desc <<< "$entry"
    if is_installed "$name"; then
        echo -e "  ${GREEN}✓${RESET} $name — ${DIM}$desc${RESET}"
        installed_names+=("$name")
    else
        echo -e "  ${YELLOW}○${RESET} $name — ${DIM}$desc${RESET}"
        missing_pkgs+=("$pkg")
    fi
done
echo

if [[ ${#missing_pkgs[@]} -eq 0 ]]; then
    echo -e "${GREEN}all dependencies are installed!${RESET}"
    echo
else
    echo -e "${YELLOW}missing packages:${RESET} ${missing_pkgs[*]}"
    echo
    if ask_yesno "install missing packages via pacman?"; then
        echo
        if [[ $EUID -ne 0 ]]; then
            echo -e "${DIM}running with sudo...${RESET}"
            if ! sudo pacman -S --needed --noconfirm "${missing_pkgs[@]}"; then
                echo -e "${RED}error: pacman failed. you may need to install manually.${RESET}" >&2
                echo -e "${DIM}run: pacman -S ${missing_pkgs[*]}${RESET}"
                echo
            else
                echo -e "${GREEN}packages installed successfully.${RESET}"
                echo
            fi
        else
            if ! pacman -S --needed --noconfirm "${missing_pkgs[@]}"; then
                echo -e "${RED}error: pacman failed. you may need to install manually.${RESET}" >&2
                echo -e "${DIM}run: pacman -S ${missing_pkgs[*]}${RESET}"
                echo
            else
                echo -e "${GREEN}packages installed successfully.${RESET}"
                echo
            fi
        fi
    else
        echo -e "${DIM}skipping package installation.${RESET}"
        echo
    fi
fi

if [[ ! -f "$ZSHRC" ]]; then
    echo -e "${RED}error: $ZSHRC not found${RESET}" >&2
    exit 1
fi

if grep -qF "$LINE" "$ZSHRC"; then
    echo -e "${GREEN}setup line already present in ~/.zshrc — nothing to do${RESET}"
    echo
    echo -e "${BOLD}setup complete!${RESET} restart your shell or run:"
    echo -e "  ${CYAN}source ~/.zshrc${RESET}"
    exit 0
fi

echo -e "${BOLD}the following line will be appended to ${CYAN}~/.zshrc${RESET}:${BOLD}${RESET}"
echo -e "  ${CYAN}$LINE${RESET}"
echo

if ! ask_yesno "proceed?"; then
    echo -e "${DIM}skipped .zshrc modification.${RESET}"
    echo
    echo -e "${BOLD}setup complete${RESET} (without .zshrc changes)."
    echo -e "${DIM}add this line to your .zshrc manually:${RESET}"
    echo -e "  ${CYAN}$LINE${RESET}"
    exit 0
fi

if ! printf '\n%s\n' "$LINE" >> "$ZSHRC"; then
    echo -e "${RED}error: failed to write to $ZSHRC${RESET}" >&2
    exit 1
fi

echo
echo -e "${GREEN}${BOLD}setup complete!${RESET} restart your shell or run:"
echo -e "  ${CYAN}source ~/.zshrc${RESET}"
