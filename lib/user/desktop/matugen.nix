{ inputs, ...}:

{
  programs.matugen = {
    enable = true;
    wallpaper = "${inputs.config-walls}/catppuccin/Zephyr_5760x2880.png";
    variant = "dark";
    # type = "scheme-vibrant";
    jsonFormat = "hex";
  };
}
