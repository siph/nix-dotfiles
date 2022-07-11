#!/bin/sh
pushd ~/.nix-dotfiles
home-manager switch --flake .#chris
popd
