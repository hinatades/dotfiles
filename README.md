# dotfiles

macOS dotfiles managed by a [Nix Home Manager](https://github.com/nix-community/home-manager) flake.

> [!NOTE]
> Nix is required. The flake manages symlinks declaratively; CLI tools and casks are installed separately via Homebrew.

## Features

- **Shell**: Zsh with [Starship](https://starship.rs/) prompt (oh-my-zsh simple theme replica)
- **Terminal**: [WezTerm](https://wezfurlong.org/wezterm/) with tmux-style keybindings for pane management
- **Editor**: [Neovim](https://neovim.io/) with [LazyVim](https://www.lazyvim.org/)
- **Multiplexer**: WezTerm built-in (tmux configuration also available if preferred)
- **Fuzzy Finder**: fzf integration for history, repository navigation, and file search
- **Window Manager**: [Hammerspoon](https://www.hammerspoon.org/) for window management
- **AI Assistant**: [Claude Code](https://claude.com/claude-code) global settings (permissions, instructions, skills)

## Configuration Files

- `.zshrc` - Zsh configuration with custom functions and keybindings
- `.tmux.conf` - tmux configuration (optional, for those who prefer tmux over WezTerm's built-in multiplexer)
- `nvim/` - Neovim/LazyVim configuration
- `starship.toml` - Starship prompt configuration
- `wezterm/` - WezTerm terminal configuration with tmux-style keybindings
- `hammerspoon/` - Hammerspoon window management configuration
- `claude/` - Claude Code global settings (symlinked to `~/.claude/`)
- `flake.nix` / `home.nix` / `flake.lock` - Home Manager flake managing symlinks declaratively

## Dropbox Sync

`.zsh_history` and `.gitconfig` are synced across machines via Dropbox. These files are not managed by the flake — set them up manually after applying the flake:

```sh
ln -s ~/Dropbox/.zsh_history ~/.zsh_history
ln -s ~/Dropbox/.gitconfig ~/.gitconfig
```

## Installation

### 1. Install Nix

Recommended: [Determinate Nix Installer](https://github.com/DeterminateSystems/nix-installer).

```sh
curl --proto '=https' --tlsv1.2 -sSf -L https://install.determinate.systems/nix | sh -s -- install
```

If using the upstream installer instead, enable flakes manually:

```sh
mkdir -p ~/.config/nix
echo "experimental-features = nix-command flakes" >> ~/.config/nix/nix.conf
```

### 2. Clone the repository

```sh
ghq get https://github.com/hinatades/dotfiles.git
cd $(ghq root)/github.com/hinatades/dotfiles
```

### 3. Apply the flake

```sh
nix run home-manager/master -- switch --flake .#hinatades -b backup
```

`-b backup` renames any pre-existing conflicting files (e.g. `~/.zshrc`) to `<name>.backup` instead of failing.

The flake uses `mkOutOfStoreSymlink`, so symlinks point at the live repo — edits take effect without rebuild.

### 4. Install CLI tools and casks (Homebrew)

The flake manages symlinks only. Install runtime tools separately:

```sh
brew install zsh zsh-autosuggestions neovim fzf ripgrep clang-format ghq gh kubectl starship d-kuro/tap/gwq
brew install --cask wezterm hammerspoon
brew install goenv pyenv nodebrew
```

> [!NOTE]
> `tmux` and `reattach-to-user-namespace` are optional. Install them only if you prefer tmux over WezTerm's built-in pane management:
> ```sh
> brew install tmux reattach-to-user-namespace
> ```

### Adding another machine

Add an entry under `homeConfigurations` in `flake.nix`:

```nix
"yourname" = mkHome {
  system = "aarch64-darwin";    # or "x86_64-linux", etc.
  username = "yourname";
  homeDirectory = "/Users/yourname";
  # optional: dotfilesPath = "/absolute/path/to/dotfiles";
};
```

Then `nix run home-manager/master -- switch --flake .#yourname -b backup`.

## Version Managers

- **Golang**: goenv
- **Python**: pyenv
- **Node.js**: nodebrew

## Key Features

### Zsh Functions

- `fzf-src` (Ctrl+Esc): Fuzzy find and navigate to repositories managed by ghq
- `fzf-src-hub` (Ctrl+]): Fuzzy find and open repository in browser with gh
- `fzf-select-history` (Ctrl+Space): Fuzzy search command history
- `fzf-gwq` (Ctrl+\): Fuzzy find and navigate to git worktrees managed by gwq
- `fvim`: Fuzzy find and open git-tracked files in Neovim
- `ide`: Split tmux window into 3-pane layout (requires tmux)

### Neovim

- `-`: Open oil.nvim file explorer (edit like a buffer: `o` to add file, `:w` to save)
- `:Fzf`: Fuzzy file finder (Telescope)
- `:Rg`: Ripgrep search in files (Telescope)

### WezTerm Keybindings

Leader key: `Ctrl+b` (tmux-style)

- `Leader + |`: Split pane horizontally
- `Leader + -`: Split pane vertically
- `Leader + h/j/k/l`: Navigate panes
- `Leader + H/J/K/L`: Resize panes (expand current pane in direction)
- `Leader + [`: Enter copy mode (for scrolling with `Ctrl+f/b/d/u`, exit with `q`)
- `Leader + 3`: Create 3-pane preset layout

> [!NOTE]
> The included `.tmux.conf` uses the same `Ctrl+b` leader key and similar keybindings, so you can switch between WezTerm and tmux with minimal adjustment.

### Hammerspoon

Window management with simple keybindings:

- `Cmd+Shift+h`: Move window to left half
- `Cmd+Shift+l`: Move window to right half
- `Cmd+Shift+j`: Maximize window
- `Cmd+Shift+k`: Center window (80% size)
- `Ctrl+Return`: Toggle WezTerm visibility

### Starship Prompt

Configured to replicate the oh-my-zsh "simple" theme with a clean, minimalist look.
