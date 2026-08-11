# config.nixos
My personal NixOS config.

## Structure:
```
 /
├──  configs       # Desktop configuration files are kept here... most (except
│                   # nvim & quickshell) of the stuff that goes in ~/.config.
│
├──  hosts         # All machines are kept here.
│   ├──  desktop   # Home tower.
│   └──  laptop    # Work laptop.
│
├──  lib           # Library of common components.
│   ├──  system    # Common components that the system/root uses.
│   └──  user      # Common components that the user uses.
│
└──  flake.nix     # Entry point.
```

## Machines:
 - [desktop](./hosts/desktop)
 - [laptop](./hosts/laptop)

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
