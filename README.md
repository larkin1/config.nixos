# config.nixos
My personal NixOS config.

## Structure:
```
 /
├──  configs       # desktop configuration files are kept here... most of the stuff that goes in ~/.config
│
├──  hosts         # all machines are kept here
│   ├──  desktop   # home tower
│   ├──  laptop    # home laptop
│   └──  work      # work tower
│
├──  lib           # library of common components
│   ├──  system    # common components that the system/root uses
│   └──  user      # common components that the user uses
│
└──  flake.nix     # entry point
```

## Machines:
 - [work](./hosts/work)
 - [desktop](./hosts/desktop)
 - [laptop](./hosts/laptop)

## Todo:
 - [x] switch to Hjem
   - [x] work
   - [x] desktop
   - [x] laptop
 - [ ] get quickshell to at least a point where it can replace my waybar
 - [ ] switch my server infra to nixos


 ## Thanks:
 Thanks to the following:
  - Catppuccin for the base of many of the config files
  - [mechabar](https://github.com/sejjy/mechabar)
  - members of the hyprland discord for helping out
