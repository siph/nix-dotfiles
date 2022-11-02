#!/bin/sh
home-manager switch --flake .#$(whoami)@$(hostname)
