{ pkgs, config, username, ... }:

let
  c = config.programs.matugen.theme.colors;
in {
  hjem.users.${username} = {
    packages = with pkgs; [
      cava
    ];
    files = {
      ".config/yazi/theme.toml".text = ''
        # : Manager [[[

        [mgr]
        cwd = { fg = "${c.on_surface.dark.color}" }

        # Find
        find_keyword  = { fg = "${c.error.dark.color}", bold = true, italic = true, underline = true }
        find_position = { fg = "${c.error.dark.color}", bold = true, italic = true }

        # Marker
        marker_copied   = { fg = "{{colors.tertiary_fixed.default.hex | auto_lightness: 20.0}}", bg = "{{colors.tertiary_fixed.default.hex | auto_lightness: 20.0}}" }
        marker_cut      = { fg = "${c.tertiary_fixed.dark.color}", bg = "${c.tertiary_fixed.dark.color}" }
        marker_marked   = { fg = "${c.error.dark.color}", bg = "${c.error.dark.color}" }
        marker_selected = { fg = "${c.tertiary.dark.color}", bg = "${c.tertiary.dark.color}" }

        # Count
        count_copied   = { fg = "${c.on_tertiary_fixed.dark.color}", bg = "${c.tertiary_fixed.dark.color}" }
        count_cut      = { fg = "${c.on_tertiary_fixed.dark.color}", bg = "${c.tertiary_fixed.dark.color}" }
        count_selected = { fg = "${c.on_primary.dark.color}", bg = "${c.tertiary.dark.color}" }

        # Border
        border_symbol = "│"
        border_style  = { fg = "${c.surface_tint.dark.color}" }

        # : ]]]


        # : Indicator [[[

        [indicator]
        padding = { open = "█", close = "█" }

        # : ]]]


        # : Tabs [[[

        [tabs]
        active    = { fg = "${c.primary.dark.color}", bold = true, bg = "${c.surface.dark.color}" }
        inactive  = { fg = "${c.secondary.dark.color}", bg = "${c.surface.dark.color}" }
        sep_inner = { open = "[", close = "]" }

        # : ]]]


        # : Mode [[[

        [mode]
        # Mode
        normal_main = { bg = "${c.primary.dark.color}", fg = "${c.on_primary.dark.color}", bold = true }
        normal_alt  = { bg = "${c.surface_variant.dark.color}", fg = "${c.on_surface_variant.dark.color}" }

        # Select mode
        select_main = { bg = "${c.secondary.dark.color}", fg = "${c.on_secondary.dark.color}", bold = true }
        select_alt  = { bg = "${c.surface_variant.dark.color}", fg = "${c.on_surface_variant.dark.color}" }

        # Unset mode
        unset_main = { bg = "${c.tertiary.dark.color}", fg = "${c.on_tertiary.dark.color}", bold = true }
        unset_alt  = { bg = "${c.surface_variant.dark.color}", fg = "${c.on_surface_variant.dark.color}" }

        # : ]]]


        # : Status [[[

        [status]
        sep_left  = { open = "🭁", close = "🭠" }
        sep_right = { open = "🭁", close = "🭠" }

        # Permissions
        perm_type  = { fg = "{{colors.secondary.default.hex | auto_lightness: 30.0}}" }
        perm_write = { fg = "{{colors.tertiary.default.hex | auto_lightness: 30.0}}" }
        perm_read  = { fg = "{{colors.error.default.hex | auto_lightness: 30.0}}" }
        perm_exec  = { fg = "{{colors.tertiary_fixed.default.hex | auto_lightness: 30.0}}" }
        perm_sep   = { fg = "{{colors.primary_fixed.default.hex | auto_lightness: 30.0}}" }

        # Progress
        progress_label  = { bold = true }
        progress_normal = { fg = "${c.primary.dark.color}", bg = "${c.surface_bright.dark.color}" }
        progress_error  = { fg = "${c.error.dark.color}", bg = "${c.surface_bright.dark.color}" }

        # : ]]]


        # : Which [[[

        [which]
        cols = 3
        mask = { bg = "${c.surface_bright.dark.color}" }
        cand = { fg = "${c.primary.dark.color}" }
        rest = { fg = "${c.on_primary.dark.color}" }
        desc = { fg = "${c.on_surface.dark.color}" }
        separator = " ▶ "
        separator_style = { fg = "${c.on_surface.dark.color}" }

        # : ]]]


        # : Notify [[[

        [notify]
        title_info  = { fg = "${c.tertiary.dark.color}" }
        title_warn  = { fg = "${c.primary.dark.color}" }
        title_error = { fg = "${c.error.dark.color}" }

        # : ]]]


        # : Picker [[[

        [pick]
        border = { fg = "${c.primary.dark.color}" }
        active = { fg = "${c.tertiary.dark.color}", bold = true }
        inactive = {}

        # : ]]]


        # : Input [[[

        [input]
        border = { fg = "${c.primary.dark.color}" }
        value  = { fg = "${c.on_surface.dark.color}" }

        # : ]]]


        # : Completion [[[

        [cmp]
        border = { fg = "${c.primary.dark.color}", bg = "${c.on_primary.dark.color}" }

        # : ]]]


        # : Tasks [[[

        [tasks]
        border  = { fg = "${c.primary.dark.color}" }
        title   = {}
        hovered = { fg = "${c.tertiary_fixed.dark.color}", underline = true }

        # : ]]]


        # : Help [[[

        [help]
        on     = { fg = "${c.on_surface.dark.color}" }
        run    = { fg = "${c.on_surface.dark.color}" }
        footer = { fg = "${c.on_secondary.dark.color}", bg = "${c.secondary.dark.color}" }

        # : ]]]


        # : File-specific styles [[[

        [filetype]

        rules = [
            # Images
            { mime = "image/*", fg = "#94e2d5" },

            # Media
            { mime = "{audio,video}/*", fg = "#f9e2af" },

            # Archives
            { mime = "application/{zip,rar,7z*,tar,gzip,xz,zstd,bzip*,lzma,compress,archive,cpio,arj,xar,ms-cab*}", fg = "#f5c2e7" },

            # Documents
            { mime = "application/{pdf,doc,rtf}", fg = "#a6e3a1" },

            # Special files
            { url = "*", is = "orphan", bg = "${c.error_container.dark.color}" },
            { url = "*", is = "exec", fg = "${c.on_error_container.dark.color}" },

            # Fallback
            { url = "*", fg = "${c.on_surface.dark.color}" },
            { url = "*/", fg = "${c.surface_tint.dark.color}" },
        ]

        # : ]]]

        [icon]
        globs = []
        dirs  = [
          { name = ".config", text = "", fg = "${c.primary.dark.color}" },
          { name = ".git", text = "", fg = "${c.primary.dark.color}" },
          { name = ".github", text = "", fg = "${c.primary.dark.color}" },
          { name = ".npm", text = "", fg = "${c.primary.dark.color}" },
          { name = "Desktop", text = "", fg = "${c.primary.dark.color}" },
          { name = "Development", text = "", fg = "${c.primary.dark.color}" },
          { name = "Documents", text = "", fg = "${c.primary.dark.color}" },
          { name = "Downloads", text = "", fg = "${c.primary.dark.color}" },
          { name = "Library", text = "", fg = "${c.primary.dark.color}" },
          { name = "Movies", text = "", fg = "${c.primary.dark.color}" },
          { name = "Music", text = "", fg = "${c.primary.dark.color}" },
          { name = "Pictures", text = "", fg = "${c.primary.dark.color}" },
          { name = "Public", text = "", fg = "${c.primary.dark.color}" },
          { name = "Videos", text = "", fg = "${c.primary.dark.color}" },
        ]
        files = [
          { name = ".babelrc", text = "", fg = "${c.primary.dark.color}" },
          { name = ".bash_profile", text = "", fg = "${c.primary.dark.color}" },
          { name = ".bashrc", text = "", fg = "${c.primary.dark.color}" },
          { name = ".clang-format", text = "", fg = "${c.primary.dark.color}" },
          { name = ".clang-tidy", text = "", fg = "${c.primary.dark.color}" },
          { name = ".codespellrc", text = "󰓆", fg = "${c.primary.dark.color}" },
          { name = ".condarc", text = "", fg = "${c.primary.dark.color}" },
          { name = ".dockerignore", text = "󰡨", fg = "${c.primary.dark.color}" },
          { name = ".ds_store", text = "", fg = "${c.primary.dark.color}" },
          { name = ".editorconfig", text = "", fg = "${c.primary.dark.color}" },
          { name = ".env", text = "", fg = "${c.primary.dark.color}" },
          { name = ".eslintignore", text = "", fg = "${c.primary.dark.color}" },
          { name = ".eslintrc", text = "", fg = "${c.primary.dark.color}" },
          { name = ".git-blame-ignore-revs", text = "", fg = "${c.primary.dark.color}" },
          { name = ".gitattributes", text = "", fg = "${c.primary.dark.color}" },
          { name = ".gitconfig", text = "", fg = "${c.primary.dark.color}" },
          { name = ".gitignore", text = "", fg = "${c.primary.dark.color}" },
          { name = ".gitlab-ci.yml", text = "", fg = "${c.primary.dark.color}" },
          { name = ".gitmodules", text = "", fg = "${c.primary.dark.color}" },
          { name = ".gtkrc-2.0", text = "", fg = "${c.primary.dark.color}" },
          { name = ".gvimrc", text = "", fg = "${c.primary.dark.color}" },
          { name = ".justfile", text = "", fg = "${c.primary.dark.color}" },
          { name = ".luacheckrc", text = "", fg = "${c.primary.dark.color}" },
          { name = ".luaurc", text = "", fg = "${c.primary.dark.color}" },
          { name = ".mailmap", text = "󰊢", fg = "${c.primary.dark.color}" },
          { name = ".nanorc", text = "", fg = "${c.primary.dark.color}" },
          { name = ".npmignore", text = "", fg = "${c.primary.dark.color}" },
          { name = ".npmrc", text = "", fg = "${c.primary.dark.color}" },
          { name = ".nuxtrc", text = "󱄆", fg = "${c.primary.dark.color}" },
          { name = ".nvmrc", text = "", fg = "${c.primary.dark.color}" },
          { name = ".pnpmfile.cjs", text = "", fg = "${c.primary.dark.color}" },
          { name = ".pre-commit-config.yaml", text = "󰛢", fg = "${c.primary.dark.color}" },
          { name = ".prettierignore", text = "", fg = "${c.primary.dark.color}" },
          { name = ".prettierrc", text = "", fg = "${c.primary.dark.color}" },
          { name = ".prettierrc.cjs", text = "", fg = "${c.primary.dark.color}" },
          { name = ".prettierrc.js", text = "", fg = "${c.primary.dark.color}" },
          { name = ".prettierrc.json", text = "", fg = "${c.primary.dark.color}" },
          { name = ".prettierrc.json5", text = "", fg = "${c.primary.dark.color}" },
          { name = ".prettierrc.mjs", text = "", fg = "${c.primary.dark.color}" },
          { name = ".prettierrc.toml", text = "", fg = "${c.primary.dark.color}" },
          { name = ".prettierrc.yaml", text = "", fg = "${c.primary.dark.color}" },
          { name = ".prettierrc.yml", text = "", fg = "${c.primary.dark.color}" },
          { name = ".pylintrc", text = "", fg = "${c.primary.dark.color}" },
          { name = ".settings.json", text = "", fg = "${c.primary.dark.color}" },
          { name = ".SRCINFO", text = "󰣇", fg = "${c.primary.dark.color}" },
          { name = ".vimrc", text = "", fg = "${c.primary.dark.color}" },
          { name = ".Xauthority", text = "", fg = "${c.primary.dark.color}" },
          { name = ".xinitrc", text = "", fg = "${c.primary.dark.color}" },
          { name = ".Xresources", text = "", fg = "${c.primary.dark.color}" },
          { name = ".xsession", text = "", fg = "${c.primary.dark.color}" },
          { name = ".zprofile", text = "", fg = "${c.primary.dark.color}" },
          { name = ".zshenv", text = "", fg = "${c.primary.dark.color}" },
          { name = ".zshrc", text = "", fg = "${c.primary.dark.color}" },
          { name = "_gvimrc", text = "", fg = "${c.primary.dark.color}" },
          { name = "_vimrc", text = "", fg = "${c.primary.dark.color}" },
          { name = "AUTHORS", text = "", fg = "${c.primary.dark.color}" },
          { name = "AUTHORS.txt", text = "", fg = "${c.primary.dark.color}" },
          { name = "brewfile", text = "", fg = "${c.primary.dark.color}" },
          { name = "bspwmrc", text = "", fg = "${c.primary.dark.color}" },
          { name = "build", text = "", fg = "${c.primary.dark.color}" },
          { name = "build.gradle", text = "", fg = "${c.primary.dark.color}" },
          { name = "build.zig.zon", text = "", fg = "${c.primary.dark.color}" },
          { name = "bun.lock", text = "", fg = "${c.primary.dark.color}" },
          { name = "bun.lockb", text = "", fg = "${c.primary.dark.color}" },
          { name = "cantorrc", text = "", fg = "${c.primary.dark.color}" },
          { name = "checkhealth", text = "󰓙", fg = "${c.primary.dark.color}" },
          { name = "cmakelists.txt", text = "", fg = "${c.primary.dark.color}" },
          { name = "code_of_conduct", text = "", fg = "${c.primary.dark.color}" },
          { name = "code_of_conduct.md", text = "", fg = "${c.primary.dark.color}" },
          { name = "commit_editmsg", text = "", fg = "${c.primary.dark.color}" },
          { name = "commitlint.config.js", text = "󰜘", fg = "${c.primary.dark.color}" },
          { name = "commitlint.config.ts", text = "󰜘", fg = "${c.primary.dark.color}" },
          { name = "compose.yaml", text = "󰡨", fg = "${c.primary.dark.color}" },
          { name = "compose.yml", text = "󰡨", fg = "${c.primary.dark.color}" },
          { name = "config", text = "", fg = "${c.primary.dark.color}" },
          { name = "containerfile", text = "󰡨", fg = "${c.primary.dark.color}" },
          { name = "copying", text = "", fg = "${c.primary.dark.color}" },
          { name = "copying.lesser", text = "", fg = "${c.primary.dark.color}" },
          { name = "Directory.Build.props", text = "", fg = "${c.primary.dark.color}" },
          { name = "Directory.Build.targets", text = "", fg = "${c.primary.dark.color}" },
          { name = "Directory.Packages.props", text = "", fg = "${c.primary.dark.color}" },
          { name = "docker-compose.yaml", text = "󰡨", fg = "${c.primary.dark.color}" },
          { name = "docker-compose.yml", text = "󰡨", fg = "${c.primary.dark.color}" },
          { name = "dockerfile", text = "󰡨", fg = "${c.primary.dark.color}" },
          { name = "eslint.config.cjs", text = "", fg = "${c.primary.dark.color}" },
          { name = "eslint.config.js", text = "", fg = "${c.primary.dark.color}" },
          { name = "eslint.config.mjs", text = "", fg = "${c.primary.dark.color}" },
          { name = "eslint.config.ts", text = "", fg = "${c.primary.dark.color}" },
          { name = "ext_typoscript_setup.txt", text = "", fg = "${c.primary.dark.color}" },
          { name = "favicon.ico", text = "", fg = "${c.primary.dark.color}" },
          { name = "fp-info-cache", text = "", fg = "${c.primary.dark.color}" },
          { name = "fp-lib-table", text = "", fg = "${c.primary.dark.color}" },
          { name = "FreeCAD.conf", text = "", fg = "${c.primary.dark.color}" },
          { name = "Gemfile", text = "", fg = "${c.primary.dark.color}" },
          { name = "gnumakefile", text = "", fg = "${c.primary.dark.color}" },
          { name = "go.mod", text = "", fg = "${c.primary.dark.color}" },
          { name = "go.sum", text = "", fg = "${c.primary.dark.color}" },
          { name = "go.work", text = "", fg = "${c.primary.dark.color}" },
          { name = "gradle-wrapper.properties", text = "", fg = "${c.primary.dark.color}" },
          { name = "gradle.properties", text = "", fg = "${c.primary.dark.color}" },
          { name = "gradlew", text = "", fg = "${c.primary.dark.color}" },
          { name = "groovy", text = "", fg = "${c.primary.dark.color}" },
          { name = "gruntfile.babel.js", text = "", fg = "${c.primary.dark.color}" },
          { name = "gruntfile.coffee", text = "", fg = "${c.primary.dark.color}" },
          { name = "gruntfile.js", text = "", fg = "${c.primary.dark.color}" },
          { name = "gruntfile.ts", text = "", fg = "${c.primary.dark.color}" },
          { name = "gtkrc", text = "", fg = "${c.primary.dark.color}" },
          { name = "gulpfile.babel.js", text = "", fg = "${c.primary.dark.color}" },
          { name = "gulpfile.coffee", text = "", fg = "${c.primary.dark.color}" },
          { name = "gulpfile.js", text = "", fg = "${c.primary.dark.color}" },
          { name = "gulpfile.ts", text = "", fg = "${c.primary.dark.color}" },
          { name = "hypridle.conf", text = "", fg = "${c.primary.dark.color}" },
          { name = "hyprland.conf", text = "", fg = "${c.primary.dark.color}" },
          { name = "hyprlandd.conf", text = "", fg = "${c.primary.dark.color}" },
          { name = "hyprlock.conf", text = "", fg = "${c.primary.dark.color}" },
          { name = "hyprpaper.conf", text = "", fg = "${c.primary.dark.color}" },
          { name = "hyprsunset.conf", text = "", fg = "${c.primary.dark.color}" },
          { name = "i18n.config.js", text = "󰗊", fg = "${c.primary.dark.color}" },
          { name = "i18n.config.ts", text = "󰗊", fg = "${c.primary.dark.color}" },
          { name = "i3blocks.conf", text = "", fg = "${c.primary.dark.color}" },
          { name = "i3status.conf", text = "", fg = "${c.primary.dark.color}" },
          { name = "index.theme", text = "", fg = "${c.primary.dark.color}" },
          { name = "ionic.config.json", text = "", fg = "${c.primary.dark.color}" },
          { name = "Jenkinsfile", text = "", fg = "${c.primary.dark.color}" },
          { name = "justfile", text = "", fg = "${c.primary.dark.color}" },
          { name = "kalgebrarc", text = "", fg = "${c.primary.dark.color}" },
          { name = "kdeglobals", text = "", fg = "${c.primary.dark.color}" },
          { name = "kdenlive-layoutsrc", text = "", fg = "${c.primary.dark.color}" },
          { name = "kdenliverc", text = "", fg = "${c.primary.dark.color}" },
          { name = "kritadisplayrc", text = "", fg = "${c.primary.dark.color}" },
          { name = "kritarc", text = "", fg = "${c.primary.dark.color}" },
          { name = "license", text = "", fg = "${c.primary.dark.color}" },
          { name = "license.md", text = "", fg = "${c.primary.dark.color}" },
          { name = "lxde-rc.xml", text = "", fg = "${c.primary.dark.color}" },
          { name = "lxqt.conf", text = "", fg = "${c.primary.dark.color}" },
          { name = "makefile", text = "", fg = "${c.primary.dark.color}" },
          { name = "mix.lock", text = "", fg = "${c.primary.dark.color}" },
          { name = "mpv.conf", text = "", fg = "${c.primary.dark.color}" },
          { name = "next.config.cjs", text = "", fg = "${c.primary.dark.color}" },
          { name = "next.config.js", text = "", fg = "${c.primary.dark.color}" },
          { name = "next.config.ts", text = "", fg = "${c.primary.dark.color}" },
          { name = "node_modules", text = "", fg = "${c.primary.dark.color}" },
          { name = "nuxt.config.cjs", text = "󱄆", fg = "${c.primary.dark.color}" },
          { name = "nuxt.config.js", text = "󱄆", fg = "${c.primary.dark.color}" },
          { name = "nuxt.config.mjs", text = "󱄆", fg = "${c.primary.dark.color}" },
          { name = "nuxt.config.ts", text = "󱄆", fg = "${c.primary.dark.color}" },
          { name = "package-lock.json", text = "", fg = "${c.primary.dark.color}" },
          { name = "package.json", text = "", fg = "${c.primary.dark.color}" },
          { name = "PKGBUILD", text = "", fg = "${c.primary.dark.color}" },
          { name = "platformio.ini", text = "", fg = "${c.primary.dark.color}" },
          { name = "playwright.config.cjs", text = "", fg = "${c.primary.dark.color}" },
          { name = "playwright.config.cts", text = "", fg = "${c.primary.dark.color}" },
          { name = "playwright.config.js", text = "", fg = "${c.primary.dark.color}" },
          { name = "playwright.config.mjs", text = "", fg = "${c.primary.dark.color}" },
          { name = "playwright.config.mts", text = "", fg = "${c.primary.dark.color}" },
          { name = "playwright.config.ts", text = "", fg = "${c.primary.dark.color}" },
          { name = "pnpm-lock.yaml", text = "", fg = "${c.primary.dark.color}" },
          { name = "pnpm-workspace.yaml", text = "", fg = "${c.primary.dark.color}" },
          { name = "pom.xml", text = "", fg = "${c.primary.dark.color}" },
          { name = "prettier.config.cjs", text = "", fg = "${c.primary.dark.color}" },
          { name = "prettier.config.js", text = "", fg = "${c.primary.dark.color}" },
          { name = "prettier.config.mjs", text = "", fg = "${c.primary.dark.color}" },
          { name = "prettier.config.ts", text = "", fg = "${c.primary.dark.color}" },
          { name = "prisma.config.mts", text = "", fg = "${c.primary.dark.color}" },
          { name = "prisma.config.ts", text = "", fg = "${c.primary.dark.color}" },
          { name = "procfile", text = "", fg = "${c.primary.dark.color}" },
          { name = "PrusaSlicer.ini", text = "", fg = "${c.primary.dark.color}" },
          { name = "PrusaSlicerGcodeViewer.ini", text = "", fg = "${c.primary.dark.color}" },
          { name = "py.typed", text = "", fg = "${c.primary.dark.color}" },
          { name = "QtProject.conf", text = "", fg = "${c.primary.dark.color}" },
          { name = "rakefile", text = "", fg = "${c.primary.dark.color}" },
          { name = "readme", text = "󰂺", fg = "${c.primary.dark.color}" },
          { name = "readme.md", text = "󰂺", fg = "${c.primary.dark.color}" },
          { name = "rmd", text = "", fg = "${c.primary.dark.color}" },
          { name = "robots.txt", text = "󰚩", fg = "${c.primary.dark.color}" },
          { name = "security", text = "󰒃", fg = "${c.primary.dark.color}" },
          { name = "security.md", text = "󰒃", fg = "${c.primary.dark.color}" },
          { name = "settings.gradle", text = "", fg = "${c.primary.dark.color}" },
          { name = "svelte.config.js", text = "", fg = "${c.primary.dark.color}" },
          { name = "sxhkdrc", text = "", fg = "${c.primary.dark.color}" },
          { name = "sym-lib-table", text = "", fg = "${c.primary.dark.color}" },
          { name = "tailwind.config.js", text = "󱏿", fg = "${c.primary.dark.color}" },
          { name = "tailwind.config.mjs", text = "󱏿", fg = "${c.primary.dark.color}" },
          { name = "tailwind.config.ts", text = "󱏿", fg = "${c.primary.dark.color}" },
          { name = "tmux.conf", text = "", fg = "${c.primary.dark.color}" },
          { name = "tmux.conf.local", text = "", fg = "${c.primary.dark.color}" },
          { name = "tsconfig.json", text = "", fg = "${c.primary.dark.color}" },
          { name = "unlicense", text = "", fg = "${c.primary.dark.color}" },
          { name = "vagrantfile", text = "", fg = "${c.primary.dark.color}" },
          { name = "vercel.json", text = "", fg = "${c.primary.dark.color}" },
          { name = "vite.config.cjs", text = "", fg = "${c.primary.dark.color}" },
          { name = "vite.config.cts", text = "", fg = "${c.primary.dark.color}" },
          { name = "vite.config.js", text = "", fg = "${c.primary.dark.color}" },
          { name = "vite.config.mjs", text = "", fg = "${c.primary.dark.color}" },
          { name = "vite.config.mts", text = "", fg = "${c.primary.dark.color}" },
          { name = "vite.config.ts", text = "", fg = "${c.primary.dark.color}" },
          { name = "vitest.config.cjs", text = "", fg = "${c.primary.dark.color}" },
          { name = "vitest.config.cts", text = "", fg = "${c.primary.dark.color}" },
          { name = "vitest.config.js", text = "", fg = "${c.primary.dark.color}" },
          { name = "vitest.config.mjs", text = "", fg = "${c.primary.dark.color}" },
          { name = "vitest.config.mts", text = "", fg = "${c.primary.dark.color}" },
          { name = "vitest.config.ts", text = "", fg = "${c.primary.dark.color}" },
          { name = "vlcrc", text = "󰕼", fg = "${c.primary.dark.color}" },
          { name = "webpack", text = "󰜫", fg = "${c.primary.dark.color}" },
          { name = "weston.ini", text = "", fg = "${c.primary.dark.color}" },
          { name = "workspace", text = "", fg = "${c.primary.dark.color}" },
          { name = "wrangler.jsonc", text = "", fg = "${c.primary.dark.color}" },
          { name = "wrangler.toml", text = "", fg = "${c.primary.dark.color}" },
          { name = "xdph.conf", text = "", fg = "${c.primary.dark.color}" },
          { name = "xmobarrc", text = "", fg = "${c.primary.dark.color}" },
          { name = "xmobarrc.hs", text = "", fg = "${c.primary.dark.color}" },
          { name = "xmonad.hs", text = "", fg = "${c.primary.dark.color}" },
          { name = "xorg.conf", text = "", fg = "${c.primary.dark.color}" },
          { name = "xsettingsd.conf", text = "", fg = "${c.primary.dark.color}" },
        ]
        exts = [
          { name = "3gp", text = "", fg = "${c.primary.dark.color}" },
          { name = "3mf", text = "󰆧", fg = "${c.primary.dark.color}" },
          { name = "7z", text = "", fg = "${c.primary.dark.color}" },
          { name = "a", text = "", fg = "${c.primary.dark.color}" },
          { name = "aac", text = "", fg = "${c.primary.dark.color}" },
          { name = "ada", text = "", fg = "${c.primary.dark.color}" },
          { name = "adb", text = "", fg = "${c.primary.dark.color}" },
          { name = "ads", text = "", fg = "${c.primary.dark.color}" },
          { name = "ai", text = "", fg = "${c.primary.dark.color}" },
          { name = "aif", text = "", fg = "${c.primary.dark.color}" },
          { name = "aiff", text = "", fg = "${c.primary.dark.color}" },
          { name = "android", text = "", fg = "${c.primary.dark.color}" },
          { name = "ape", text = "", fg = "${c.primary.dark.color}" },
          { name = "apk", text = "", fg = "${c.primary.dark.color}" },
          { name = "apl", text = "", fg = "${c.primary.dark.color}" },
          { name = "app", text = "", fg = "${c.primary.dark.color}" },
          { name = "applescript", text = "", fg = "${c.primary.dark.color}" },
          { name = "asc", text = "󰦝", fg = "${c.primary.dark.color}" },
          { name = "asm", text = "", fg = "${c.primary.dark.color}" },
          { name = "ass", text = "󰨖", fg = "${c.primary.dark.color}" },
          { name = "astro", text = "", fg = "${c.primary.dark.color}" },
          { name = "avif", text = "", fg = "${c.primary.dark.color}" },
          { name = "awk", text = "", fg = "${c.primary.dark.color}" },
          { name = "azcli", text = "", fg = "${c.primary.dark.color}" },
          { name = "bak", text = "󰁯", fg = "${c.primary.dark.color}" },
          { name = "bash", text = "", fg = "${c.primary.dark.color}" },
          { name = "bat", text = "", fg = "${c.primary.dark.color}" },
          { name = "bazel", text = "", fg = "${c.primary.dark.color}" },
          { name = "bib", text = "󱉟", fg = "${c.primary.dark.color}" },
          { name = "bicep", text = "", fg = "${c.primary.dark.color}" },
          { name = "bicepparam", text = "", fg = "${c.primary.dark.color}" },
          { name = "bin", text = "", fg = "${c.primary.dark.color}" },
          { name = "blade.php", text = "", fg = "${c.primary.dark.color}" },
          { name = "blend", text = "󰂫", fg = "${c.primary.dark.color}" },
          { name = "blp", text = "󰺾", fg = "${c.primary.dark.color}" },
          { name = "bmp", text = "", fg = "${c.primary.dark.color}" },
          { name = "bqn", text = "", fg = "${c.primary.dark.color}" },
          { name = "brep", text = "󰻫", fg = "${c.primary.dark.color}" },
          { name = "bz", text = "", fg = "${c.primary.dark.color}" },
          { name = "bz2", text = "", fg = "${c.primary.dark.color}" },
          { name = "bz3", text = "", fg = "${c.primary.dark.color}" },
          { name = "bzl", text = "", fg = "${c.primary.dark.color}" },
          { name = "c", text = "", fg = "${c.primary.dark.color}" },
          { name = "c++", text = "", fg = "${c.primary.dark.color}" },
          { name = "cache", text = "", fg = "${c.primary.dark.color}" },
          { name = "cast", text = "", fg = "${c.primary.dark.color}" },
          { name = "cbl", text = "", fg = "${c.primary.dark.color}" },
          { name = "cc", text = "", fg = "${c.primary.dark.color}" },
          { name = "ccm", text = "", fg = "${c.primary.dark.color}" },
          { name = "cfc", text = "", fg = "${c.primary.dark.color}" },
          { name = "cfg", text = "", fg = "${c.primary.dark.color}" },
          { name = "cfm", text = "", fg = "${c.primary.dark.color}" },
          { name = "cjs", text = "", fg = "${c.primary.dark.color}" },
          { name = "clj", text = "", fg = "${c.primary.dark.color}" },
          { name = "cljc", text = "", fg = "${c.primary.dark.color}" },
          { name = "cljd", text = "", fg = "${c.primary.dark.color}" },
          { name = "cljs", text = "", fg = "${c.primary.dark.color}" },
          { name = "cmake", text = "", fg = "${c.primary.dark.color}" },
          { name = "cob", text = "", fg = "${c.primary.dark.color}" },
          { name = "cobol", text = "", fg = "${c.primary.dark.color}" },
          { name = "coffee", text = "", fg = "${c.primary.dark.color}" },
          { name = "conda", text = "", fg = "${c.primary.dark.color}" },
          { name = "conf", text = "", fg = "${c.primary.dark.color}" },
          { name = "config.ru", text = "", fg = "${c.primary.dark.color}" },
          { name = "cow", text = "󰆚", fg = "${c.primary.dark.color}" },
          { name = "cp", text = "", fg = "${c.primary.dark.color}" },
          { name = "cpp", text = "", fg = "${c.primary.dark.color}" },
          { name = "cppm", text = "", fg = "${c.primary.dark.color}" },
          { name = "cpy", text = "", fg = "${c.primary.dark.color}" },
          { name = "cr", text = "", fg = "${c.primary.dark.color}" },
          { name = "crdownload", text = "", fg = "${c.primary.dark.color}" },
          { name = "cs", text = "󰌛", fg = "${c.primary.dark.color}" },
          { name = "csh", text = "", fg = "${c.primary.dark.color}" },
          { name = "cshtml", text = "󱦗", fg = "${c.primary.dark.color}" },
          { name = "cson", text = "", fg = "${c.primary.dark.color}" },
          { name = "csproj", text = "󰪮", fg = "${c.primary.dark.color}" },
          { name = "css", text = "", fg = "${c.primary.dark.color}" },
          { name = "csv", text = "", fg = "${c.primary.dark.color}" },
          { name = "cts", text = "", fg = "${c.primary.dark.color}" },
          { name = "cu", text = "", fg = "${c.primary.dark.color}" },
          { name = "cue", text = "󰲹", fg = "${c.primary.dark.color}" },
          { name = "cuh", text = "", fg = "${c.primary.dark.color}" },
          { name = "cxx", text = "", fg = "${c.primary.dark.color}" },
          { name = "cxxm", text = "", fg = "${c.primary.dark.color}" },
          { name = "d", text = "", fg = "${c.primary.dark.color}" },
          { name = "d.ts", text = "", fg = "${c.primary.dark.color}" },
          { name = "dart", text = "", fg = "${c.primary.dark.color}" },
          { name = "db", text = "", fg = "${c.primary.dark.color}" },
          { name = "dconf", text = "", fg = "${c.primary.dark.color}" },
          { name = "desktop", text = "", fg = "${c.primary.dark.color}" },
          { name = "diff", text = "", fg = "${c.primary.dark.color}" },
          { name = "dll", text = "", fg = "${c.primary.dark.color}" },
          { name = "doc", text = "󰈬", fg = "${c.primary.dark.color}" },
          { name = "Dockerfile", text = "󰡨", fg = "${c.primary.dark.color}" },
          { name = "dockerignore", text = "󰡨", fg = "${c.primary.dark.color}" },
          { name = "docx", text = "󰈬", fg = "${c.primary.dark.color}" },
          { name = "dot", text = "󱁉", fg = "${c.primary.dark.color}" },
          { name = "download", text = "", fg = "${c.primary.dark.color}" },
          { name = "drl", text = "", fg = "${c.primary.dark.color}" },
          { name = "dropbox", text = "", fg = "${c.primary.dark.color}" },
          { name = "dump", text = "", fg = "${c.primary.dark.color}" },
          { name = "dwg", text = "󰻫", fg = "${c.primary.dark.color}" },
          { name = "dxf", text = "󰻫", fg = "${c.primary.dark.color}" },
          { name = "ebook", text = "", fg = "${c.primary.dark.color}" },
          { name = "ebuild", text = "", fg = "${c.primary.dark.color}" },
          { name = "edn", text = "", fg = "${c.primary.dark.color}" },
          { name = "eex", text = "", fg = "${c.primary.dark.color}" },
          { name = "ejs", text = "", fg = "${c.primary.dark.color}" },
          { name = "el", text = "", fg = "${c.primary.dark.color}" },
          { name = "elc", text = "", fg = "${c.primary.dark.color}" },
          { name = "elf", text = "", fg = "${c.primary.dark.color}" },
          { name = "elm", text = "", fg = "${c.primary.dark.color}" },
          { name = "eln", text = "", fg = "${c.primary.dark.color}" },
          { name = "env", text = "", fg = "${c.primary.dark.color}" },
          { name = "eot", text = "", fg = "${c.primary.dark.color}" },
          { name = "epp", text = "", fg = "${c.primary.dark.color}" },
          { name = "epub", text = "", fg = "${c.primary.dark.color}" },
          { name = "erb", text = "", fg = "${c.primary.dark.color}" },
          { name = "erl", text = "", fg = "${c.primary.dark.color}" },
          { name = "ex", text = "", fg = "${c.primary.dark.color}" },
          { name = "exe", text = "", fg = "${c.primary.dark.color}" },
          { name = "exs", text = "", fg = "${c.primary.dark.color}" },
          { name = "f#", text = "", fg = "${c.primary.dark.color}" },
          { name = "f3d", text = "󰻫", fg = "${c.primary.dark.color}" },
          { name = "f90", text = "󱈚", fg = "${c.primary.dark.color}" },
          { name = "fbx", text = "󰆧", fg = "${c.primary.dark.color}" },
          { name = "fcbak", text = "", fg = "${c.primary.dark.color}" },
          { name = "fcmacro", text = "", fg = "${c.primary.dark.color}" },
          { name = "fcmat", text = "", fg = "${c.primary.dark.color}" },
          { name = "fcparam", text = "", fg = "${c.primary.dark.color}" },
          { name = "fcscript", text = "", fg = "${c.primary.dark.color}" },
          { name = "fcstd", text = "", fg = "${c.primary.dark.color}" },
          { name = "fcstd1", text = "", fg = "${c.primary.dark.color}" },
          { name = "fctb", text = "", fg = "${c.primary.dark.color}" },
          { name = "fctl", text = "", fg = "${c.primary.dark.color}" },
          { name = "fdmdownload", text = "", fg = "${c.primary.dark.color}" },
          { name = "feature", text = "", fg = "${c.primary.dark.color}" },
          { name = "fish", text = "", fg = "${c.primary.dark.color}" },
          { name = "flac", text = "", fg = "${c.primary.dark.color}" },
          { name = "flc", text = "", fg = "${c.primary.dark.color}" },
          { name = "flf", text = "", fg = "${c.primary.dark.color}" },
          { name = "fnl", text = "", fg = "${c.primary.dark.color}" },
          { name = "fodg", text = "", fg = "${c.primary.dark.color}" },
          { name = "fodp", text = "", fg = "${c.primary.dark.color}" },
          { name = "fods", text = "", fg = "${c.primary.dark.color}" },
          { name = "fodt", text = "", fg = "${c.primary.dark.color}" },
          { name = "frag", text = "", fg = "${c.primary.dark.color}" },
          { name = "fs", text = "", fg = "${c.primary.dark.color}" },
          { name = "fsi", text = "", fg = "${c.primary.dark.color}" },
          { name = "fsscript", text = "", fg = "${c.primary.dark.color}" },
          { name = "fsx", text = "", fg = "${c.primary.dark.color}" },
          { name = "gcode", text = "󰐫", fg = "${c.primary.dark.color}" },
          { name = "gd", text = "", fg = "${c.primary.dark.color}" },
          { name = "gemspec", text = "", fg = "${c.primary.dark.color}" },
          { name = "geom", text = "", fg = "${c.primary.dark.color}" },
          { name = "gif", text = "", fg = "${c.primary.dark.color}" },
          { name = "git", text = "", fg = "${c.primary.dark.color}" },
          { name = "glb", text = "", fg = "${c.primary.dark.color}" },
          { name = "gleam", text = "", fg = "${c.primary.dark.color}" },
          { name = "glsl", text = "", fg = "${c.primary.dark.color}" },
          { name = "gnumakefile", text = "", fg = "${c.primary.dark.color}" },
          { name = "go", text = "", fg = "${c.primary.dark.color}" },
          { name = "godot", text = "", fg = "${c.primary.dark.color}" },
          { name = "gpr", text = "", fg = "${c.primary.dark.color}" },
          { name = "gql", text = "", fg = "${c.primary.dark.color}" },
          { name = "gradle", text = "", fg = "${c.primary.dark.color}" },
          { name = "graphql", text = "", fg = "${c.primary.dark.color}" },
          { name = "gresource", text = "", fg = "${c.primary.dark.color}" },
          { name = "gv", text = "󱁉", fg = "${c.primary.dark.color}" },
          { name = "gz", text = "", fg = "${c.primary.dark.color}" },
          { name = "h", text = "", fg = "${c.primary.dark.color}" },
          { name = "haml", text = "", fg = "${c.primary.dark.color}" },
          { name = "hbs", text = "", fg = "${c.primary.dark.color}" },
          { name = "heex", text = "", fg = "${c.primary.dark.color}" },
          { name = "hex", text = "", fg = "${c.primary.dark.color}" },
          { name = "hh", text = "", fg = "${c.primary.dark.color}" },
          { name = "hpp", text = "", fg = "${c.primary.dark.color}" },
          { name = "hrl", text = "", fg = "${c.primary.dark.color}" },
          { name = "hs", text = "", fg = "${c.primary.dark.color}" },
          { name = "htm", text = "", fg = "${c.primary.dark.color}" },
          { name = "html", text = "", fg = "${c.primary.dark.color}" },
          { name = "http", text = "", fg = "${c.primary.dark.color}" },
          { name = "huff", text = "󰡘", fg = "${c.primary.dark.color}" },
          { name = "hurl", text = "", fg = "${c.primary.dark.color}" },
          { name = "hx", text = "", fg = "${c.primary.dark.color}" },
          { name = "hxx", text = "", fg = "${c.primary.dark.color}" },
          { name = "ical", text = "", fg = "${c.primary.dark.color}" },
          { name = "icalendar", text = "", fg = "${c.primary.dark.color}" },
          { name = "ico", text = "", fg = "${c.primary.dark.color}" },
          { name = "ics", text = "", fg = "${c.primary.dark.color}" },
          { name = "ifb", text = "", fg = "${c.primary.dark.color}" },
          { name = "ifc", text = "󰻫", fg = "${c.primary.dark.color}" },
          { name = "ige", text = "󰻫", fg = "${c.primary.dark.color}" },
          { name = "iges", text = "󰻫", fg = "${c.primary.dark.color}" },
          { name = "igs", text = "󰻫", fg = "${c.primary.dark.color}" },
          { name = "image", text = "", fg = "${c.primary.dark.color}" },
          { name = "img", text = "", fg = "${c.primary.dark.color}" },
          { name = "import", text = "", fg = "${c.primary.dark.color}" },
          { name = "info", text = "", fg = "${c.primary.dark.color}" },
          { name = "ini", text = "", fg = "${c.primary.dark.color}" },
          { name = "ino", text = "", fg = "${c.primary.dark.color}" },
          { name = "ipynb", text = "", fg = "${c.primary.dark.color}" },
          { name = "iso", text = "", fg = "${c.primary.dark.color}" },
          { name = "ixx", text = "", fg = "${c.primary.dark.color}" },
          { name = "jar", text = "", fg = "${c.primary.dark.color}" },
          { name = "java", text = "", fg = "${c.primary.dark.color}" },
          { name = "jl", text = "", fg = "${c.primary.dark.color}" },
          { name = "jpeg", text = "", fg = "${c.primary.dark.color}" },
          { name = "jpg", text = "", fg = "${c.primary.dark.color}" },
          { name = "js", text = "", fg = "${c.primary.dark.color}" },
          { name = "json", text = "", fg = "${c.primary.dark.color}" },
          { name = "json5", text = "", fg = "${c.primary.dark.color}" },
          { name = "jsonc", text = "", fg = "${c.primary.dark.color}" },
          { name = "jsx", text = "", fg = "${c.primary.dark.color}" },
          { name = "jwmrc", text = "", fg = "${c.primary.dark.color}" },
          { name = "jxl", text = "", fg = "${c.primary.dark.color}" },
          { name = "kbx", text = "󰯄", fg = "${c.primary.dark.color}" },
          { name = "kdb", text = "", fg = "${c.primary.dark.color}" },
          { name = "kdbx", text = "", fg = "${c.primary.dark.color}" },
          { name = "kdenlive", text = "", fg = "${c.primary.dark.color}" },
          { name = "kdenlivetitle", text = "", fg = "${c.primary.dark.color}" },
          { name = "kicad_dru", text = "", fg = "${c.primary.dark.color}" },
          { name = "kicad_mod", text = "", fg = "${c.primary.dark.color}" },
          { name = "kicad_pcb", text = "", fg = "${c.primary.dark.color}" },
          { name = "kicad_prl", text = "", fg = "${c.primary.dark.color}" },
          { name = "kicad_pro", text = "", fg = "${c.primary.dark.color}" },
          { name = "kicad_sch", text = "", fg = "${c.primary.dark.color}" },
          { name = "kicad_sym", text = "", fg = "${c.primary.dark.color}" },
          { name = "kicad_wks", text = "", fg = "${c.primary.dark.color}" },
          { name = "ko", text = "", fg = "${c.primary.dark.color}" },
          { name = "kpp", text = "", fg = "${c.primary.dark.color}" },
          { name = "kra", text = "", fg = "${c.primary.dark.color}" },
          { name = "krz", text = "", fg = "${c.primary.dark.color}" },
          { name = "ksh", text = "", fg = "${c.primary.dark.color}" },
          { name = "kt", text = "", fg = "${c.primary.dark.color}" },
          { name = "kts", text = "", fg = "${c.primary.dark.color}" },
          { name = "lck", text = "", fg = "${c.primary.dark.color}" },
          { name = "leex", text = "", fg = "${c.primary.dark.color}" },
          { name = "less", text = "", fg = "${c.primary.dark.color}" },
          { name = "lff", text = "", fg = "${c.primary.dark.color}" },
          { name = "lhs", text = "", fg = "${c.primary.dark.color}" },
          { name = "lib", text = "", fg = "${c.primary.dark.color}" },
          { name = "license", text = "", fg = "${c.primary.dark.color}" },
          { name = "liquid", text = "", fg = "${c.primary.dark.color}" },
          { name = "lock", text = "", fg = "${c.primary.dark.color}" },
          { name = "log", text = "󰌱", fg = "${c.primary.dark.color}" },
          { name = "lrc", text = "󰨖", fg = "${c.primary.dark.color}" },
          { name = "lua", text = "", fg = "${c.primary.dark.color}" },
          { name = "luac", text = "", fg = "${c.primary.dark.color}" },
          { name = "luau", text = "", fg = "${c.primary.dark.color}" },
          { name = "m", text = "", fg = "${c.primary.dark.color}" },
          { name = "m3u", text = "󰲹", fg = "${c.primary.dark.color}" },
          { name = "m3u8", text = "󰲹", fg = "${c.primary.dark.color}" },
          { name = "m4a", text = "", fg = "${c.primary.dark.color}" },
          { name = "m4v", text = "", fg = "${c.primary.dark.color}" },
          { name = "magnet", text = "", fg = "${c.primary.dark.color}" },
          { name = "makefile", text = "", fg = "${c.primary.dark.color}" },
          { name = "markdown", text = "", fg = "${c.primary.dark.color}" },
          { name = "material", text = "", fg = "${c.primary.dark.color}" },
          { name = "md", text = "", fg = "${c.primary.dark.color}" },
          { name = "md5", text = "󰕥", fg = "${c.primary.dark.color}" },
          { name = "mdx", text = "", fg = "${c.primary.dark.color}" },
          { name = "mint", text = "󰌪", fg = "${c.primary.dark.color}" },
          { name = "mjs", text = "", fg = "${c.primary.dark.color}" },
          { name = "mk", text = "", fg = "${c.primary.dark.color}" },
          { name = "mkv", text = "", fg = "${c.primary.dark.color}" },
          { name = "ml", text = "", fg = "${c.primary.dark.color}" },
          { name = "mli", text = "", fg = "${c.primary.dark.color}" },
          { name = "mm", text = "", fg = "${c.primary.dark.color}" },
          { name = "mo", text = "", fg = "${c.primary.dark.color}" },
          { name = "mobi", text = "", fg = "${c.primary.dark.color}" },
          { name = "mojo", text = "", fg = "${c.primary.dark.color}" },
          { name = "mov", text = "", fg = "${c.primary.dark.color}" },
          { name = "mp3", text = "", fg = "${c.primary.dark.color}" },
          { name = "mp4", text = "", fg = "${c.primary.dark.color}" },
          { name = "mpp", text = "", fg = "${c.primary.dark.color}" },
          { name = "msf", text = "", fg = "${c.primary.dark.color}" },
          { name = "mts", text = "", fg = "${c.primary.dark.color}" },
          { name = "mustache", text = "", fg = "${c.primary.dark.color}" },
          { name = "nfo", text = "", fg = "${c.primary.dark.color}" },
          { name = "nim", text = "", fg = "${c.primary.dark.color}" },
          { name = "nix", text = "", fg = "${c.primary.dark.color}" },
          { name = "norg", text = "", fg = "${c.primary.dark.color}" },
          { name = "nswag", text = "", fg = "${c.primary.dark.color}" },
          { name = "nu", text = "", fg = "${c.primary.dark.color}" },
          { name = "o", text = "", fg = "${c.primary.dark.color}" },
          { name = "obj", text = "󰆧", fg = "${c.primary.dark.color}" },
          { name = "odf", text = "", fg = "${c.primary.dark.color}" },
          { name = "odg", text = "", fg = "${c.primary.dark.color}" },
          { name = "odin", text = "󰟢", fg = "${c.primary.dark.color}" },
          { name = "odp", text = "", fg = "${c.primary.dark.color}" },
          { name = "ods", text = "", fg = "${c.primary.dark.color}" },
          { name = "odt", text = "", fg = "${c.primary.dark.color}" },
          { name = "oga", text = "", fg = "${c.primary.dark.color}" },
          { name = "ogg", text = "", fg = "${c.primary.dark.color}" },
          { name = "ogv", text = "", fg = "${c.primary.dark.color}" },
          { name = "ogx", text = "", fg = "${c.primary.dark.color}" },
          { name = "opus", text = "", fg = "${c.primary.dark.color}" },
          { name = "org", text = "", fg = "${c.primary.dark.color}" },
          { name = "otf", text = "", fg = "${c.primary.dark.color}" },
          { name = "out", text = "", fg = "${c.primary.dark.color}" },
          { name = "part", text = "", fg = "${c.primary.dark.color}" },
          { name = "patch", text = "", fg = "${c.primary.dark.color}" },
          { name = "pck", text = "", fg = "${c.primary.dark.color}" },
          { name = "pcm", text = "", fg = "${c.primary.dark.color}" },
          { name = "pdf", text = "", fg = "${c.primary.dark.color}" },
          { name = "php", text = "", fg = "${c.primary.dark.color}" },
          { name = "pl", text = "", fg = "${c.primary.dark.color}" },
          { name = "pls", text = "󰲹", fg = "${c.primary.dark.color}" },
          { name = "ply", text = "󰆧", fg = "${c.primary.dark.color}" },
          { name = "pm", text = "", fg = "${c.primary.dark.color}" },
          { name = "png", text = "", fg = "${c.primary.dark.color}" },
          { name = "po", text = "", fg = "${c.primary.dark.color}" },
          { name = "pot", text = "", fg = "${c.primary.dark.color}" },
          { name = "pp", text = "", fg = "${c.primary.dark.color}" },
          { name = "ppt", text = "󰈧", fg = "${c.primary.dark.color}" },
          { name = "pptx", text = "󰈧", fg = "${c.primary.dark.color}" },
          { name = "prisma", text = "", fg = "${c.primary.dark.color}" },
          { name = "pro", text = "", fg = "${c.primary.dark.color}" },
          { name = "ps1", text = "󰨊", fg = "${c.primary.dark.color}" },
          { name = "psb", text = "", fg = "${c.primary.dark.color}" },
          { name = "psd", text = "", fg = "${c.primary.dark.color}" },
          { name = "psd1", text = "󰨊", fg = "${c.primary.dark.color}" },
          { name = "psm1", text = "󰨊", fg = "${c.primary.dark.color}" },
          { name = "pub", text = "󰷖", fg = "${c.primary.dark.color}" },
          { name = "pxd", text = "", fg = "${c.primary.dark.color}" },
          { name = "pxi", text = "", fg = "${c.primary.dark.color}" },
          { name = "py", text = "", fg = "${c.primary.dark.color}" },
          { name = "pyc", text = "", fg = "${c.primary.dark.color}" },
          { name = "pyd", text = "", fg = "${c.primary.dark.color}" },
          { name = "pyi", text = "", fg = "${c.primary.dark.color}" },
          { name = "pyo", text = "", fg = "${c.primary.dark.color}" },
          { name = "pyw", text = "", fg = "${c.primary.dark.color}" },
          { name = "pyx", text = "", fg = "${c.primary.dark.color}" },
          { name = "qm", text = "", fg = "${c.primary.dark.color}" },
          { name = "qml", text = "", fg = "${c.primary.dark.color}" },
          { name = "qrc", text = "", fg = "${c.primary.dark.color}" },
          { name = "qss", text = "", fg = "${c.primary.dark.color}" },
          { name = "query", text = "", fg = "${c.primary.dark.color}" },
          { name = "R", text = "󰟔", fg = "${c.primary.dark.color}" },
          { name = "r", text = "󰟔", fg = "${c.primary.dark.color}" },
          { name = "rake", text = "", fg = "${c.primary.dark.color}" },
          { name = "rar", text = "", fg = "${c.primary.dark.color}" },
          { name = "rasi", text = "", fg = "${c.primary.dark.color}" },
          { name = "razor", text = "󱦘", fg = "${c.primary.dark.color}" },
          { name = "rb", text = "", fg = "${c.primary.dark.color}" },
          { name = "res", text = "", fg = "${c.primary.dark.color}" },
          { name = "resi", text = "", fg = "${c.primary.dark.color}" },
          { name = "rlib", text = "", fg = "${c.primary.dark.color}" },
          { name = "rmd", text = "", fg = "${c.primary.dark.color}" },
          { name = "rproj", text = "󰗆", fg = "${c.primary.dark.color}" },
          { name = "rs", text = "", fg = "${c.primary.dark.color}" },
          { name = "rss", text = "", fg = "${c.primary.dark.color}" },
          { name = "s", text = "", fg = "${c.primary.dark.color}" },
          { name = "sass", text = "", fg = "${c.primary.dark.color}" },
          { name = "sbt", text = "", fg = "${c.primary.dark.color}" },
          { name = "sc", text = "", fg = "${c.primary.dark.color}" },
          { name = "scad", text = "", fg = "${c.primary.dark.color}" },
          { name = "scala", text = "", fg = "${c.primary.dark.color}" },
          { name = "scm", text = "󰘧", fg = "${c.primary.dark.color}" },
          { name = "scss", text = "", fg = "${c.primary.dark.color}" },
          { name = "sh", text = "", fg = "${c.primary.dark.color}" },
          { name = "sha1", text = "󰕥", fg = "${c.primary.dark.color}" },
          { name = "sha224", text = "󰕥", fg = "${c.primary.dark.color}" },
          { name = "sha256", text = "󰕥", fg = "${c.primary.dark.color}" },
          { name = "sha384", text = "󰕥", fg = "${c.primary.dark.color}" },
          { name = "sha512", text = "󰕥", fg = "${c.primary.dark.color}" },
          { name = "sig", text = "󰘧", fg = "${c.primary.dark.color}" },
          { name = "signature", text = "󰘧", fg = "${c.primary.dark.color}" },
          { name = "skp", text = "󰻫", fg = "${c.primary.dark.color}" },
          { name = "sldasm", text = "󰻫", fg = "${c.primary.dark.color}" },
          { name = "sldprt", text = "󰻫", fg = "${c.primary.dark.color}" },
          { name = "slim", text = "", fg = "${c.primary.dark.color}" },
          { name = "sln", text = "", fg = "${c.primary.dark.color}" },
          { name = "slnx", text = "", fg = "${c.primary.dark.color}" },
          { name = "slvs", text = "󰻫", fg = "${c.primary.dark.color}" },
          { name = "sml", text = "󰘧", fg = "${c.primary.dark.color}" },
          { name = "so", text = "", fg = "${c.primary.dark.color}" },
          { name = "sol", text = "", fg = "${c.primary.dark.color}" },
          { name = "spec.js", text = "", fg = "${c.primary.dark.color}" },
          { name = "spec.jsx", text = "", fg = "${c.primary.dark.color}" },
          { name = "spec.ts", text = "", fg = "${c.primary.dark.color}" },
          { name = "spec.tsx", text = "", fg = "${c.primary.dark.color}" },
          { name = "spx", text = "", fg = "${c.primary.dark.color}" },
          { name = "sql", text = "", fg = "${c.primary.dark.color}" },
          { name = "sqlite", text = "", fg = "${c.primary.dark.color}" },
          { name = "sqlite3", text = "", fg = "${c.primary.dark.color}" },
          { name = "srt", text = "󰨖", fg = "${c.primary.dark.color}" },
          { name = "ssa", text = "󰨖", fg = "${c.primary.dark.color}" },
          { name = "ste", text = "󰻫", fg = "${c.primary.dark.color}" },
          { name = "step", text = "󰻫", fg = "${c.primary.dark.color}" },
          { name = "stl", text = "󰆧", fg = "${c.primary.dark.color}" },
          { name = "stories.js", text = "", fg = "${c.primary.dark.color}" },
          { name = "stories.jsx", text = "", fg = "${c.primary.dark.color}" },
          { name = "stories.mjs", text = "", fg = "${c.primary.dark.color}" },
          { name = "stories.svelte", text = "", fg = "${c.primary.dark.color}" },
          { name = "stories.ts", text = "", fg = "${c.primary.dark.color}" },
          { name = "stories.tsx", text = "", fg = "${c.primary.dark.color}" },
          { name = "stories.vue", text = "", fg = "${c.primary.dark.color}" },
          { name = "stp", text = "󰻫", fg = "${c.primary.dark.color}" },
          { name = "strings", text = "", fg = "${c.primary.dark.color}" },
          { name = "styl", text = "", fg = "${c.primary.dark.color}" },
          { name = "sub", text = "󰨖", fg = "${c.primary.dark.color}" },
          { name = "sublime", text = "", fg = "${c.primary.dark.color}" },
          { name = "suo", text = "", fg = "${c.primary.dark.color}" },
          { name = "sv", text = "󰍛", fg = "${c.primary.dark.color}" },
          { name = "svelte", text = "", fg = "${c.primary.dark.color}" },
          { name = "svg", text = "󰜡", fg = "${c.primary.dark.color}" },
          { name = "svgz", text = "󰜡", fg = "${c.primary.dark.color}" },
          { name = "svh", text = "󰍛", fg = "${c.primary.dark.color}" },
          { name = "swift", text = "", fg = "${c.primary.dark.color}" },
          { name = "t", text = "", fg = "${c.primary.dark.color}" },
          { name = "tbc", text = "󰛓", fg = "${c.primary.dark.color}" },
          { name = "tcl", text = "󰛓", fg = "${c.primary.dark.color}" },
          { name = "templ", text = "", fg = "${c.primary.dark.color}" },
          { name = "terminal", text = "", fg = "${c.primary.dark.color}" },
          { name = "test.js", text = "", fg = "${c.primary.dark.color}" },
          { name = "test.jsx", text = "", fg = "${c.primary.dark.color}" },
          { name = "test.ts", text = "", fg = "${c.primary.dark.color}" },
          { name = "test.tsx", text = "", fg = "${c.primary.dark.color}" },
          { name = "tex", text = "", fg = "${c.primary.dark.color}" },
          { name = "tf", text = "", fg = "${c.primary.dark.color}" },
          { name = "tfvars", text = "", fg = "${c.primary.dark.color}" },
          { name = "tgz", text = "", fg = "${c.primary.dark.color}" },
          { name = "tmpl", text = "", fg = "${c.primary.dark.color}" },
          { name = "tmux", text = "", fg = "${c.primary.dark.color}" },
          { name = "toml", text = "", fg = "${c.primary.dark.color}" },
          { name = "torrent", text = "", fg = "${c.primary.dark.color}" },
          { name = "tres", text = "", fg = "${c.primary.dark.color}" },
          { name = "ts", text = "", fg = "${c.primary.dark.color}" },
          { name = "tscn", text = "", fg = "${c.primary.dark.color}" },
          { name = "tsconfig", text = "", fg = "${c.primary.dark.color}" },
          { name = "tsx", text = "", fg = "${c.primary.dark.color}" },
          { name = "ttf", text = "", fg = "${c.primary.dark.color}" },
          { name = "twig", text = "", fg = "${c.primary.dark.color}" },
          { name = "txt", text = "󰈙", fg = "${c.primary.dark.color}" },
          { name = "txz", text = "", fg = "${c.primary.dark.color}" },
          { name = "typ", text = "", fg = "${c.primary.dark.color}" },
          { name = "typoscript", text = "", fg = "${c.primary.dark.color}" },
          { name = "ui", text = "", fg = "${c.primary.dark.color}" },
          { name = "v", text = "󰍛", fg = "${c.primary.dark.color}" },
          { name = "vala", text = "", fg = "${c.primary.dark.color}" },
          { name = "vert", text = "", fg = "${c.primary.dark.color}" },
          { name = "vh", text = "󰍛", fg = "${c.primary.dark.color}" },
          { name = "vhd", text = "󰍛", fg = "${c.primary.dark.color}" },
          { name = "vhdl", text = "󰍛", fg = "${c.primary.dark.color}" },
          { name = "vi", text = "", fg = "${c.primary.dark.color}" },
          { name = "vim", text = "", fg = "${c.primary.dark.color}" },
          { name = "vsh", text = "", fg = "${c.primary.dark.color}" },
          { name = "vsix", text = "", fg = "${c.primary.dark.color}" },
          { name = "vue", text = "", fg = "${c.primary.dark.color}" },
          { name = "wasm", text = "", fg = "${c.primary.dark.color}" },
          { name = "wav", text = "", fg = "${c.primary.dark.color}" },
          { name = "webm", text = "", fg = "${c.primary.dark.color}" },
          { name = "webmanifest", text = "", fg = "${c.primary.dark.color}" },
          { name = "webp", text = "", fg = "${c.primary.dark.color}" },
          { name = "webpack", text = "󰜫", fg = "${c.primary.dark.color}" },
          { name = "wma", text = "", fg = "${c.primary.dark.color}" },
          { name = "wmv", text = "", fg = "${c.primary.dark.color}" },
          { name = "woff", text = "", fg = "${c.primary.dark.color}" },
          { name = "woff2", text = "", fg = "${c.primary.dark.color}" },
          { name = "wrl", text = "󰆧", fg = "${c.primary.dark.color}" },
          { name = "wrz", text = "󰆧", fg = "${c.primary.dark.color}" },
          { name = "wv", text = "", fg = "${c.primary.dark.color}" },
          { name = "wvc", text = "", fg = "${c.primary.dark.color}" },
          { name = "x", text = "", fg = "${c.primary.dark.color}" },
          { name = "xaml", text = "󰙳", fg = "${c.primary.dark.color}" },
          { name = "xcf", text = "", fg = "${c.primary.dark.color}" },
          { name = "xcplayground", text = "", fg = "${c.primary.dark.color}" },
          { name = "xcstrings", text = "", fg = "${c.primary.dark.color}" },
          { name = "xls", text = "󰈛", fg = "${c.primary.dark.color}" },
          { name = "xlsx", text = "󰈛", fg = "${c.primary.dark.color}" },
          { name = "xm", text = "", fg = "${c.primary.dark.color}" },
          { name = "xml", text = "󰗀", fg = "${c.primary.dark.color}" },
          { name = "xpi", text = "", fg = "${c.primary.dark.color}" },
          { name = "xslt", text = "󰗀", fg = "${c.primary.dark.color}" },
          { name = "xul", text = "", fg = "${c.primary.dark.color}" },
          { name = "xz", text = "", fg = "${c.primary.dark.color}" },
          { name = "yaml", text = "", fg = "${c.primary.dark.color}" },
          { name = "yml", text = "", fg = "${c.primary.dark.color}" },
          { name = "zig", text = "", fg = "${c.primary.dark.color}" },
          { name = "zip", text = "", fg = "${c.primary.dark.color}" },
          { name = "zsh", text = "", fg = "${c.primary.dark.color}" },
          { name = "zst", text = "", fg = "${c.primary.dark.color}" },
          { name = "🔥", text = "", fg = "${c.primary.dark.color}" },
        ]
        conds = [
          # Special files
          { if = "orphan", text = "", fg = "${c.primary.dark.color}" },
          { if = "link", text = "", fg = "${c.primary.dark.color}" },
          { if = "block", text = "", fg = "${c.primary.dark.color}" },
          { if = "char", text = "", fg = "${c.primary.dark.color}" },
          { if = "fifo", text = "", fg = "${c.primary.dark.color}" },
          { if = "sock", text = "", fg = "${c.primary.dark.color}" },
          { if = "sticky", text = "", fg = "${c.primary.dark.color}" },
          { if = "dummy", text = "", fg = "${c.primary.dark.color}" },

          # Fallback
          { if = "dir", text = "", fg = "${c.primary.dark.color}" },
          { if = "exec", text = "", fg = "${c.primary.dark.color}" },
          { if = "!dir", text = "", fg = "${c.primary.dark.color}" },
        ]
        # : }}}
      '';
    };
  };
}
