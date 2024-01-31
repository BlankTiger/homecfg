{ pkgs, ... }:
{
  home.packages = with pkgs; [
    neovim-nightly
  ];

  home.file.".config/nvim" = {
    source = ./config;
    recursive = true;
  };
}
