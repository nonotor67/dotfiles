#! /usr/bin/env zsh

sudo pacman -S $(cat pkglist) &&\
  stow --target="$HOME" --no-folding .
