{
  description = "Home Manager configuration of blanktiger";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    nixpkgs-stable.url = "github:nixos/nixpkgs/release-24.11";
    home-manager = {
      url = "github:nix-community/home-manager";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    firefox-addons = {
      url = "gitlab:rycee/nur-expressions?dir=pkgs/firefox-addons";
      inputs.nixpkgs.follows = "nixpkgs";
    };
    neovim-nightly-overlay.url = "github:nix-community/neovim-nightly-overlay";
    hyprland.url = "github:hyprwm/Hyprland";
    ghostty = {
      url = "github:ghostty-org/ghostty";
    };
    zig = {
      url = "github:mitchellh/zig-overlay";
      inputs = {
        nixpkgs.follows = "nixpkgs-stable";
        flake-compat.follows = "";
      };
    };
  };

  outputs = { nixpkgs, nixpkgs-stable, home-manager, hyprland, zig, ... }@inputs:
    let
      system = "x86_64-linux";
      pkgs = nixpkgs.legacyPackages.${system};
      overlays = [ inputs.neovim-nightly-overlay.overlay ];
    in {
      homeConfigurations."blanktiger" = home-manager.lib.homeManagerConfiguration {
        inherit pkgs;
        # configuration = { pkgs, ... }: { nixpkgs.overlays = overlays; };
        extraSpecialArgs = { inherit inputs; inherit system; };
        modules = [
          ({
           nixpkgs.overlays = overlays;
          })
          ./home.nix
          # ./programs/zsh.nix
          # ./programs/fish.nix
          ./programs/git.nix
          # ./programs/starship.nix
          # ./programs/kitty
          ./programs/ghostty
          # ./programs/wezterm
          ./programs/tmux
          ./programs/nvim
          # ./programs/irefox
          # hyprland.homeManagerModules.default
          # { wayland.windowManager.hyprland.enable = true; }
          # ./programs/hyprland.nix
        ];
      };
    };
}
