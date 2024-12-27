{ pkgs, ... }:
{
  home.file.".config/ghostty" = {
    source = ./config;
    recursive = true;
  };
}
