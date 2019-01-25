#!/usr/bin/env bash

# Install oh-my-zsh if it's not in our $HOME dir; otherwise try to upgrade it...
if [[ ! -d "$HOME/.oh-my-zsh" ]]; then
  echo "Oh My Zsh not found, will attempt to install it!"
  sh -c "$(curl -fsSL https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh)"
else
  echo "Oh My Zsh installation found, will attempt to upgrade it!"
  sh "$HOME/.oh-my-zsh/tools/upgrade.sh"
fi
