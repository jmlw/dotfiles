#!/usr/bin/env bash

# Install oh-my-zsh if it's not in our $HOME dir; otherwise try to upgrade it...
if [[ ! -d "$HOME/.oh-my-zsh" ]]; then
  echo "Oh My Zsh not found, will attempt to install it!"
  sh -c "$(curl -fsSL https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh | sed '/\s*env\s\s*zsh\s*/d')"
else
  echo "Oh My Zsh installation found, will attempt to upgrade it!"
  sh "$HOME/.oh-my-zsh/tools/upgrade.sh"
fi

if [[ ! -d "$HOME/.oh-my-zsh/custom/themes/powerlevel9k" ]]; then
  echo "Installing Powerlevel9k theme!"
  git clone https://github.com/bhilburn/powerlevel9k.git ~/.oh-my-zsh/custom/themes/powerlevel9k
fi

if [[ ! -d "$HOME/.oh-my-zsh/custom/themes/powerlevel10k" ]]; then
  echo "Installing Powerlevel10k theme!"
  git clone --depth=1 https://github.com/romkatv/powerlevel10k.git ${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/themes/powerlevel10k
fi

