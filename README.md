# config.nixos
My personal NixOS config.

## Structure:
```
 /
├──  configs       # desktop configuration files are kept here... most of the stuff that goes in ~/.config
│
├──  hosts         # all machines are kept here
│   ├──  desktop   # home tower
│   ├──  laptop    # home laptop - needs to be converted to Hjem still
│   └──  work      # work tower
│
├──  lib           # library of common components
│   ├── 󱂵 home      # home-manager common components - TO BE REMOVED
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
 - [ ] switch to Hjem
   - [x] work
   - [x] desktop
   - [ ] laptop
 - [ ] get quickshell to at least a point where it can replace my waybar
 - [ ] switch my server infra to nixos
