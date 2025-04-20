{ config, pkgs, inputs, ... }:
{
  home.username = "blanktiger";
  home.homeDirectory = "/home/blanktiger";
  home.stateVersion = "23.11";

  home.packages = with pkgs; [
    # zsh
    # zsh-completions
    # zsh-syntax-highlighting
    # zsh-autosuggestions

    # python3
    # python3Packages.pip
    # python3Packages.virtualenv
    pyenv
    sccache
    rustup
    tokei

    # musl
    mold
    # cmake
    # clang
    # libcxx
    # glibc

    # cacert
    # libiconv
    # pkg-config
    # openssl
    # openssl_1_1
    # openssl_3_1

    # gcc
    perf-tools
    linuxPackages_latest.perf
    flamegraph

    curl
    wget
    git
    tmux
    ripgrep
    fd
    bat
    # fzf
    jq
    fx
    silver-searcher

    just
    eza
    tldr
    htop
    bottom
    xsel

    neofetch
    bitwarden
    ueberzugpp
    imagemagick
    inkscape
    gimp
    zathura
    #mpv
    # youtube-dl
    ffmpeg
  ];

  home.file = {
    # # Building this configuration will create a copy of 'dotfiles/screenrc' in
    # # the Nix store. Activating the configuration will then make '~/.screenrc' a
    # # symlink to the Nix store copy.
    # ".screenrc".source = dotfiles/screenrc;

    # # You can also set the file content immediately.
    # ".gradle/gradle.properties".text = ''
    #   org.gradle.console=verbose
    #   org.gradle.daemon.idletimeout=3600000
    # '';
  };

  home.sessionVariables = {
    EDITOR = "nvim";
    RUSTC_WRAPPER = "sccache";
    ENABLE_CORRECTION = "true";
    TERMINAL="kitty";
    BROWSER="firefox";
    SHELL = "fish";
    # OPENSSL_DEV = pkgs.openssl.dev;
    # PKG_CONFIG_PATH = pkgs.openssl.dev + "/lib/pkgconfig";
    # LD_LIBRARY_PATH = pkgs.openssl.out + "/lib";
  };

  xdg.enable = true;
  xdg.mimeApps.defaultApplications = {
    "text/html" = "firefox.desktop";
    "text/plain" = "nvim.desktop";
    "application/pdf" = "zathura.desktop";
    "video/mp4" = "mpv.desktop";
    "video/*" = "mpv.desktop";
  };

  programs.home-manager.enable = true;
  manual.manpages.enable = true;
}
