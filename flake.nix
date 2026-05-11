{
  description = "hinatades dotfiles — Home Manager flake (light-weight symlink approach)";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixos-unstable";
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = { self, nixpkgs, home-manager, ... }:
    let
      mkHome = { system, username, homeDirectory, dotfilesPath ? null }:
        home-manager.lib.homeManagerConfiguration {
          pkgs = nixpkgs.legacyPackages.${system};
          modules = [ ./home.nix ];
          extraSpecialArgs = {
            inherit username homeDirectory;
            dotfilesPath =
              if dotfilesPath != null
              then dotfilesPath
              else "${homeDirectory}/ghq/github.com/hinatades/dotfiles";
          };
        };
    in {
      homeConfigurations = {
        "hinatades" = mkHome {
          system = "aarch64-darwin";
          username = "hinatades";
          homeDirectory = "/Users/hinatades";
        };
      };
    };
}
