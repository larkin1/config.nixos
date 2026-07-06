# more of a zsh config than a starship config at this point but oh well

my zsh prompt and shell config. it has the [Starship](https://starship.rs/) and the [Catppuccin](https://catppuccin.com/)

## stuff

- **Starship prompt** - `starship.toml` (catppuccin macchiato palette)
- **Persistent history** - 10k commands saved to `~/.zsh_history` across sessions
- **History substring search** - type a prefix, press ↑/↓ to match history (zsh-history-substring-search)
- **Syntax highlighting** - catppuccin mocha color scheme for zsh-syntax-highlighting
- **Smart aliases** - uses modern tools when available, falls back to classic commands
- **Zoxide** - smarter `cd` with fuzzy matching (`cdi` for interactive mode)
- **Vi mode** - `bindkey -v`
- **Tab completion** - zsh built-in compinit with menu select
- **Dependency checker** - warns about missing tools on startup
- **Sources install dirs and changes default gopath to be hidden** - idk what idk how to explain this any further ahh

## you need:

| dep | why | how |
|---|---|---|
| [starship](https://starship.rs/) ≥ 1.0 | Prompt engine | `curl -sS https://starship.rs/install.sh \| sh` |
| [zsh-history-substring-search](https://github.com/zsh-users/zsh-history-substring-search) | History search on ↑/↓ | System package (`pacman -S zsh-history-substring-search`, `apt install zsh-history-substring-search`, etc.) |
| [zsh-syntax-highlighting](https://github.com/zsh-users/zsh-syntax-highlighting) | Syntax coloring | System package (`pacman -S zsh-syntax-highlighting`, `apt install zsh-syntax-highlighting`, etc.) |
| [Nerd Font](https://www.nerdfonts.com/) | Prompt icons | Install any Nerd Font and set it as your terminal font |

## aliases

these commands are aliased, and thus may behave slightly different... if the replacements aren't installed i think my script should complain about that but everything should still work. 

| command | what it invokes | falls back to | how |
|---|---|---|---|
| `ls` | [eza](https://github.com/eza-community/eza) `--icons` | `ls --color=auto` | `pacman -S eza` / `apt install eza` |
| `ll` | `eza -l --icons` | `ls -l --color=auto` | (same) |
| `la` | `eza -la --icons` | `ls -la --color=auto` | (same) |
| `lt` | `eza --tree --icons` | `tree` | (same) |
| `lta` | `eza --tree --icons -a` | - | (same) |
| `cat` | [bat](https://github.com/sharkdp/bat) `--paging=never` | `cat` | `pacman -S bat` / `apt install bat` |
| `cd` | [zoxide](https://github.com/ajeetdsouza/zoxide) (`cdi` for interactive) | `cd` | `pacman -S zoxide` / `apt install zoxide` |

## recommended programs

helps my dumbass rember what to install

| dep | instead of | how |
|---|---|---|
| [fd](https://github.com/sharkdp/fd) | `find` | `pacman -S fd` / `apt install fd-find` |
| [ripgrep](https://github.com/BurntSushi/ripgrep) | `grep` | `pacman -S ripgrep` / `apt install ripgrep` |

## you needa do this before anything works

```sh
# 1. Clone this repo
git clone https://github.com/larkin1/config.starship.git ~/.config/starship

# 2. Add this line to ~/.zshrc
source "$HOME/.config/starship/init.zsh"
```
