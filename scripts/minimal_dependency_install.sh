#!/bin/bash

DOTFILES_DIR="$HOME/.dotfiles"

change_to_zsh() {
  if [ "$(echo "$SHELL" | grep -c "zsh")" -eq "0" ]; then
    echo "Setting shell to zsh"
    chsh -s "$(which zsh)"
  else
    echo "zsh is already the default shell"
  fi
}

local_install() {
  echo "Installing local packages..."
  if [ "$(uname)" = "Linux" ]; then
    "$DOTFILES_DIR"/scripts/minimal_apt_setup.sh
  else
    echo "No local packages to install..."
  fi
  echo "Finished installing local packages"
}


install() {
  local_install
}

change_to_zsh
install
