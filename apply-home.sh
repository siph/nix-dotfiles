#!/bin/sh
pushd ~/.dotfiles
home-manager switch --flake .#chris
popd
