{ config, pkgs, lib, username, homeDirectory, dotfilesPath, ... }:

let
  link = path: config.lib.file.mkOutOfStoreSymlink "${dotfilesPath}/${path}";
in
{
  home.username = username;
  home.homeDirectory = homeDirectory;
  home.stateVersion = "24.11";

  home.file = {
    ".zshrc".source = link ".zshrc";
    ".tmux.conf".source = link ".tmux.conf";
    ".hammerspoon".source = link "hammerspoon";
    ".claude/settings.json".source = link "claude/settings.json";
    ".claude/skills".source = link "claude/skills";
    ".claude/instructions.md".source = link "claude/instructions.md";
  };

  xdg.configFile = {
    "nvim".source = link "nvim";
    "wezterm".source = link "wezterm";
    "starship.toml".source = link "starship.toml";
  };

  programs.home-manager.enable = true;
}
