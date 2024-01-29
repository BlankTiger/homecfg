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
  };

  outputs = { nixpkgs, home-manager, ... }@inputs:
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
          ./programs/starship.nix
          ./programs/kitty
          # ./programs/nvim.nix
          # ./programs/firefox.nix
        ];
      };
    };
}
