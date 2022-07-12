#!/bin/sh
pushd ~/.nix-dotfiles
export NIXPKGS_ALLOW_UNFREE=1
home-manager switch --impure --flake .#chris
popd
