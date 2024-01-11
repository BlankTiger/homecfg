# <p align="center">🏠 homecfg 🏠</p>

This project uses nix home-manager to manage my user configuration in a simple and declarative way.

## Using this config

To use this config you have to:

1. Install [nix](https://nixos.org/) (package manager, not the OS)
2. Enable nix-command and flakes (I did it in `/etc/nix/nix.conf`, but you can also do it in `~/.config/nix/nix.conf` I think):
```
extra-experimental-features = nix-command flakes
```
3. Clone this repo and put it in `~/.config` as `home-manager`
4. Enter a shell with home-manager, and set it up permanently by doing:
```bash
nix-shell -p home-manager
home-manager switch
```
