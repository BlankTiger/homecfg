{
  description = "Home Manager configuration of blanktiger";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    nixpkgs-stable.url = "github:nixos/nixpkgs/release-24.11";
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    hyprland.url = "github:hyprwm/Hyprland";
  };

  outputs = { nixpkgs, nixpkgs-stable, home-manager, hyprland, zig, ... }@inputs:
    let
      system = "x86_64-linux";
      pkgs = nixpkgs.legacyPackages.${system};
      overlays = [ inputs.neovim-nightly-overlay.overlay ];
    in {
      homeConfigurations."blanktiger" = home-manager.lib.homeManagerConfiguration {
        inherit pkgs;
        extraSpecialArgs = { inherit inputs; inherit system; };
        modules = [
          ({
           nixpkgs.overlays = overlays;
          })
          ./home.nix
          ./programs/zsh.nix
        ];
      };
    };
}
