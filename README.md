<div align="center">
<pre>
                 888          888     .d888 d8b 888
                 888          888    d88P"  Y8P 888
                 888          888    888        888
             .d88888  .d88b.  888888 888888 888 888  .d88b.  .d8888b
            d88" 888 d88""88b 888    888    888 888 d8P  Y8b 88K
            888  888 888  888 888    888    888 888 88888888 "Y8888b.
            Y88b 888 Y88..88P Y88b.  888    888 888 Y8b.          X88
             "Y88888  "Y88P"   "Y888 888    888 888  "Y8888   88888P"

                         github.com/hinatades/dotfiles
</pre>
</div>

My macOS Dotfiles.

## Features

- **Shell**: Zsh with [Starship](https://starship.rs/) prompt (oh-my-zsh simple theme replica)
- **Terminal**: [WezTerm](https://wezfurlong.org/wezterm/) with tmux-style keybindings
- **Editor**: [Neovim](https://neovim.io/) with [LazyVim](https://www.lazyvim.org/)
- **Multiplexer**: tmux
- **Fuzzy Finder**: fzf integration for history, repository navigation, and file search
- **Window Manager**: [Hammerspoon](https://www.hammerspoon.org/) for window management

## Configuration Files

- `.zshrc` - Zsh configuration with custom functions and keybindings
- `.tmux.conf` - tmux configuration
- `nvim/` - Neovim/LazyVim configuration
- `starship.toml` - Starship prompt configuration
- `wezterm/` - WezTerm terminal configuration
- `hammerspoon/` - Hammerspoon window management configuration
- `set-symboliclink.sh` - Setup script for creating symbolic links

## Dropbox Sync

This dotfiles setup syncs critical files across machines via Dropbox:

- `.zsh_history` - Command history sync
- `.gitconfig` - Git configuration

**Setup:** Place these files in `~/Dropbox/` before running the setup script. The script creates symlinks automatically.

## Installation

### 1. Install Required Tools

Install the following with [Homebrew](https://brew.sh/):

```sh
brew install zsh zsh-autosuggestions neovim tmux reattach-to-user-namespace fzf ripgrep clang-format ghq gh kubectl starship
brew install --cask wezterm hammerspoon
```

### 2. Install Version Managers

```sh
brew install goenv pyenv nodebrew
```

### 3. Clone Repository

Clone the repository with [ghq](https://github.com/x-motemen/ghq):

```sh
ghq get https://github.com/hinatades/dotfiles.git
cd $(ghq root)/github.com/hinatades/dotfiles
```

### 4. Run Setup Script

```sh
./set-symboliclink.sh
```

This will create symbolic links for all configuration files.

## Version Managers

- **Golang**: goenv
- **Python**: pyenv
- **Node.js**: nodebrew

## Key Features

### Zsh Functions

- `fzf-src` (Ctrl+Esc): Fuzzy find and navigate to repositories managed by ghq
- `fzf-src-hub` (Ctrl+]): Fuzzy find and open repository in browser with gh
- `fzf-select-history` (Ctrl+Space): Fuzzy search command history
- `fvim`: Fuzzy find and open git-tracked files in Neovim
- `ide`: Split tmux window into 3-pane layout

### WezTerm Keybindings

Leader key: `Ctrl+b` (tmux-style)

- `Leader + |`: Split pane horizontally
- `Leader + -`: Split pane vertically
- `Leader + h/j/k/l`: Navigate panes
- `Leader + H/J/K/L`: Resize panes (expand current pane in direction)
- `Leader + [`: Enter copy mode (for scrolling with `Ctrl+f/b/d/u`, exit with `q`)
- `Leader + 3`: Create 3-pane preset layout

### Hammerspoon

Window management with simple keybindings:

- `Cmd+Shift+h`: Move window to left half
- `Cmd+Shift+l`: Move window to right half
- `Cmd+Shift+j`: Maximize window
- `Cmd+Shift+k`: Center window (80% size)
- `Ctrl+Return`: Toggle WezTerm visibility

### Starship Prompt

Configured to replicate the oh-my-zsh "simple" theme with a clean, minimalist look.
