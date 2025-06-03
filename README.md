![flake check](https://github.com/siph/nix-dotfiles/actions/workflows/check.yaml/badge.svg)

# Nix Config

This is my personalized configuration for nix and nixos systems. This is
incredibly customized and subject to force pushes and general chaos and should
only be forked or used as a reference.

## Screenshots

### Xmonad

![xmonad-3](./doc/xmonad_3.png)

## Workflow

This is primarily a NixOS config but is mostly portable to non-NixOS machines
via nix + home-manager. This is a developers machine but is also general
purpose and used for everyday tasks. It can play games with Steam or Lutris and
edit audio projects with Ardour.

Development is done in neovim + tmux. The neovim configuration lives in it's
own [repository](https://www.github.com/siph/nixvim-flake) and is complete with
LSP, syntax highlighting, debugging and more.

## Usage

### Installing

- Use `nix develop` to create a bootstrap shell.
- Run `sudo nixos-rebuild switch --flake .#hostname` to apply your system
  configuration.
  - If you're still on a live installation medium, run `nixos-install --flake
.#hostname` instead, and reboot.
- Run `home-manager switch --flake .#username@hostname` to apply your home
  configuration.

### Starting Desktop Environments

This config does not use a login-manager and instead uses wrapper scripts to
launch a DE/WM with it's configurations directly from a tty. There are multiple
desktop environments/window managers. The scripts are built and placed on PATH
automatically by nix.

#### KDE

Launch xsession KDE5 session.

```shell
startx-kde
```

#### Xmonad

Launch [Xmonad](./home-manager/applications/window-managers/xmonad/xmonad.hs) session, polybar, dunst + extras.

```shell
startx-xmonad
```

#### Qtile

Launch [Qtile](./home-manager/applications/window-managers/qtile/src/config.py) session.

```shell
startx-qtile
```
