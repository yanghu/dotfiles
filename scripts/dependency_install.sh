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

create_ssh() {
  mkdir -p "$HOME"/.ssh
  chmod 0700 "$HOME"/.ssh
}

fonts_install() {
  echo "Installing fonts..."
  if ! [ -d ~/.local/share/fonts ]; then
    "$DOTFILES_DIR"/fonts/install.sh
  else
    echo "Fonts already installed"
  fi
  echo "Finished fonts"
}

local_install() {
  echo "Installing local packages..."
  if [ "$(uname)" = "Linux" ]; then
    "$DOTFILES_DIR"/scripts/apt_setup.sh
  else
    echo "No local packages to install..."
  fi
  echo "Finished installing local packages"
}


install() {
  fonts_install
  local_install
}

create_ssh
change_to_zsh
install
