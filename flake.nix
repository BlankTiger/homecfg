{
  description = "Home Manager configuration of blanktiger";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
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
  };

  outputs = { nixpkgs, home-manager, hyprland, ... }@inputs:
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
          ./programs/zsh.nix
          # ./programs/fish.nix
          ./programs/git.nix
          ./programs/starship.nix
          ./programs/kitty
          ./programs/wezterm
          ./programs/tmux
          ./programs/nvim
          # ./programs/firefox
          # hyprland.homeManagerModules.default
          # { wayland.windowManager.hyprland.enable = true; }
# ./programs/hyprland.nix
        ];
      };
    };
}
