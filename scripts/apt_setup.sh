#!/bin/bash

# Essentials
sudo apt-get install \
  cmake \
  colordiff \
  curl \
  exuberant-ctags \
  fzf \
  gawk \
  git \
  golang \
  htop \
  nodejs \
  npm \
  perl \
  python-dev \
  python3-dev \
  ripgrep \
  shellcheck \
  tmux \
  tree \
  vim-nox \
  xclip \
  zsh

echo -n "Do you want to install QMK related packages(y/n)? "
read answer
if [ "$answer" != "${answer#[Yy]}" ] ;then
    echo "Installing QMK packages..."
    # QMK things
    sudo apt-get install \
      avr-libc \
      binutils-arm-none-eabi \
      binutils-avr \
      dfu-programmer \
      dfu-util \
      gcc \
      gcc-arm-none-eabi \
      gcc-avr \
      libnewlib-arm-none-eabi \
      teensy-loader-cli \
      unzip \
      wget \
      zip
else
    echo "Skipped QMK install..."
fi
