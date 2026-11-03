# config.nixos
My personal NixOS config.

## Structure:
```
 /
├──  configs       # Desktop configuration files are kept here... most (except nvim,
│                   # quickshell & wallpapers) of the stuff that goes in ~/.config.
│
├──  hosts         # All machines are kept here.
│   ├──  desktop   # Home tower.
│   ├──  laptop    # Work laptop.
│   ├──  typhon    # Server Host.
│   ├──  tartarus  # Secure VM.
│   ├──  chiron    # Stable VM.
│   └──  pegasus   # Dev VM.
│
├──  lib           # Library of common components.
│   ├──  system    # Common components that the system/root uses.
│   ├──  user      # Common components that the user uses.
│   └──  server    # Common components that the server uses.
│
└──  flake.nix     # Entry point.
```

## Hosts:
 - [desktop](./hosts/desktop)
 - [laptop](./hosts/laptop)
 - [typhon](./hosts/typhon)
 - [tartarus](./hosts/tartarus)
 - [chiron](./hosts/chiron)
 - [pegasus](./hosts/pegasus)

## Todo:
 - [x] switch to Hjem
   - [x] desktop
   - [x] laptop
 - [x] get quickshell to at least a point where it can replace my waybar
 - [ ] switch my server infra to nixos


 ## Thanks:
 Thanks to the following:
  - Catppuccin for the base of many of the config files
  - [mechabar](https://github.com/sejjy/mechabar) for inspiration for my quickshell bar etc
  - members of the hyprland discord for helping out
