local C = require("lua.mocha")

hl.config({
  general = {
    gaps_in = 5,
    gaps_out = 10,
    border_size = 2,
    col = {
      active_border = C.surface2,
      inactive_border = C.crust,
    }
  },

  cursor = {
    no_hardware_cursors = 1,
  },

  decoration = {
    rounding = 8,
    rounding_power = 2.0,
    active_opacity = 1.0,
    inactive_opacity = 1.0,
    fullscreen_opacity = 1.0,

    shadow = {
      enabled = true,
      range = 4,
      render_power = 3,
      color = C.crust,
    },

    blur = {
      enabled = true,
      size = 6,
      passes = 2,
      vibrancy = 0.1696,
      brightness = 1.2,
      popups = true,
      popups_ignorealpha = 1,
    },
  },

  dwindle = {
    preserve_split = true,
  },

  misc = {
    disable_hyprland_logo = true,
    font_family = "JetBrains Mono Nerd Font",
  },

  animations = {
    enabled = true,
    workspace_wraparound = false,
  }
})

-- Default easing curves
hl.curve("easeOutQuint",   { type = "bezier", points = { {0.23, 1},    {0.32, 1}    } })
hl.curve("easeInOutCubic", { type = "bezier", points = { {0.65, 0.05}, {0.36, 1}    } })
hl.curve("linear",         { type = "bezier", points = { {0, 0},       {1, 1}       } })
hl.curve("almostLinear",   { type = "bezier", points = { {0.5, 0.5},   {0.75, 1}    } })
hl.curve("quick",          { type = "bezier", points = { {0.15, 0},    {0.1, 1}     } })

-- Default springs
hl.curve("easy",           { type = "spring", mass = 2, stiffness = 240, dampening = 25 })

-- Animations
hl.animation({ leaf = "global",        enabled = true,  speed = 5,   bezier = "default" })

hl.animation({ leaf = "border",        enabled = true,  speed = 1.5, bezier = "almostLinear" })

hl.animation({ leaf = "windows",       enabled = true,  speed = 1,   bezier = "default" })
hl.animation({ leaf = "windowsIn",     enabled = true,  speed = 1.5, bezier = "almostLinear", style = "popin 80%" })
hl.animation({ leaf = "windowsOut",    enabled = true,  speed = 1.2, bezier = "almostLinear", style = "popin 80%" })

hl.animation({ leaf = "fadeIn",        enabled = true,  speed = 2.5, bezier = "almostLinear" })
hl.animation({ leaf = "fadeOut",       enabled = true,  speed = 2.5, bezier = "almostLinear" })
hl.animation({ leaf = "fade",          enabled = true,  speed = 2.5, bezier = "quick" })

hl.animation({ leaf = "layers",        enabled = false, speed = 1,   bezier = "easeOutQuint" })
hl.animation({ leaf = "layersIn",      enabled = false, speed = 1,   bezier = "easeOutQuint", style = "fade" })
hl.animation({ leaf = "layersOut",     enabled = false, speed = 1,   bezier = "linear",       style = "fade" })
hl.animation({ leaf = "fadeLayersIn",  enabled = true,  speed = 2.5, bezier = "almostLinear" })
hl.animation({ leaf = "fadeLayersOut", enabled = true,  speed = 1.8, bezier = "almostLinear" })

hl.animation({ leaf = "workspaces",    enabled = true,  speed = 1.2, bezier = "almostLinear", style = "slidevert" })
hl.animation({ leaf = "workspacesIn",  enabled = true,  speed = 1.2, bezier = "almostLinear", style = "slidefadevert" })
hl.animation({ leaf = "workspacesOut", enabled = true,  speed = 1.2, bezier = "almostLinear", style = "slidefadevert" })

hl.animation({ leaf = "zoomFactor",    enabled = true,  speed = 2,   bezier = "quick" })







