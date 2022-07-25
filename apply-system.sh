#!/bin/sh
pushd ~/.nix-dotfiles
sudo nixos-rebuild switch --flake .#
popd
