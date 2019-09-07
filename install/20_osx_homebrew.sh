#!/usr/bin/env bash
# OSX-only stuff. Abort if not OSX.
is_osx || return 1

# Install Homebrew.
if [[ ! "$(type -P brew)" ]]; then
  e_header "Installing Homebrew"
  true | ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
fi

# Exit if, for some reason, Homebrew is not installed.
[[ ! "$(type -P brew)" ]] && e_error "Homebrew failed to install." && return 1

e_header "Updating Homebrew"
brew doctor
brew update

# Functions used in subsequent init scripts.

# Tap Homebrew kegs.
function brew_tap_kegs() {
  kegs=($(setdiff "${kegs[*]}" "$(brew tap)"))
  if (( ${#kegs[@]} > 0 )); then
    e_header "Tapping Homebrew kegs: ${kegs[*]}"
    for keg in "${kegs[@]}"; do
      brew tap $keg
    done
  fi
}

# Install Homebrew formulae.
function brew_install_formulae() {
  formulae=($(setdiff "${formulae[*]}" "$(brew list)"))
  if (( ${#formulae[@]} > 0 )); then
    e_header "Installing Homebrew formulae: ${formulae[*]}"
    for formula in "${formulae[@]}"; do
      brew install $formula
    done
  fi
}



#######################################
# Install any missing formulas or casks
#######################################


#######################
# Install Brew Formulae
#######################
[[ ! "$(type -P brew)" ]] && e_error "Brew formulae need Homebrew to install." && return 1

# Homebrew formulae
formulae=(
  ack
  ansible
  ant
  awscli
  bash
  cmatrix
  coreutils
  coreutils
  cowsay
  dark-mode
  editorconfig
  findutils
  git
  git-extras
  git-flow
  git-lfs
  gnu-sed
  gpg
  gradle
  htop-osx
  hub
  id3tool
  jq
  lesspipe
  man2html
  maven
  mercurial
  moreutils
  nmap
  perl
  postgresql
  pipenv
  python
  python3
  docker-compose
  rbenv
  reattach-to-user-namespace
  rename
  rtv
  ruby
  ruby-build
  screen
  sl
  sqlite
  ssh-copy-id
  syncthing
  terminal-notifier
  terraform
  the_silver_searcher
  thefuck
  tmux
  tmux-xpanes
  tree
  vim
  wget
  yarn
  zsh
  jhipster
)

brew_install_formulae

# Misc cleanup!

# This is where brew stores its binary symlinks
_brew_bin_root="$(brew --config | awk '/HOMEBREW_PREFIX/ {print $2}')"/bin

# htop
if [[ "$(type -P $_brew_bin_root/htop)" ]] && [[ "$(stat -L -f "%Su:%Sg" "$_brew_bin_root/htop")" != "root:wheel" || ! "$(($(stat -L -f "%DMp" "$_brew_bin_root/htop") & 4))" ]]; then
  e_header "Updating htop permissions"
  sudo chown root:wheel "$_brew_bin_root/htop"
  sudo chmod u+s "$_brew_bin_root/htop"
fi

# bash
if [[ "$(type -P $_brew_bin_root/bash)" && "$(cat /etc/shells | grep -q "$_brew_bin_root/bash")" ]]; then
  e_header "Adding $_brew_bin_root/bash to the list of acceptable shells"
  echo "$_brew_bin_root/bash" | sudo tee -a /etc/shells >/dev/null
fi
if [[ "$(dscl . -read ~ UserShell | awk '{print $2}')" != "$_brew_bin_root/bash" ]]; then
  e_header "Making $_brew_bin_root/bash your default shell"
  sudo chsh -s "$_brew_bin_root/bash" "$USER" >/dev/null 2>&1
  e_arrow "Please exit and restart all your shells."
fi


###############
# Install Casks
###############

[[ ! "$(type -P brew)" ]] && e_error "Brew casks need Homebrew to install." && return 1

# Ensure the cask kegs are installed.
kegs=(
  caskroom/cask
  caskroom/drivers
  caskroom/fonts
  homebrew/cask-versions
)
brew_tap_kegs

# Hack to show the first-run brew-cask password prompt immediately.
brew cask info this-is-somewhat-annoying 2>/dev/null

# Homebrew casks
casks=(
  # Applications
  a-better-finder-rename
  android-file-transfer
  android-platform-tools
  aerial
  boostnote
  chromium
  datagrip
  disk-inventory-x
  docker
  dropbox
  balenaetcher
#  filezilla
  firefox
  gitter
  google-chrome
  hermes
  insomniax
  intellij-idea
  iterm2
  java
  jd-gui
  keep
  licecap
  macdown
  macvim
  mediahuman-audio-converter
  mysqlworkbench
  osxfuse
  pgadmin4
  plex-media-player
  plexamp
  postman
  pycharm
  robo-3t
  skype
  slack
  sourcetree
  spectacle
  spotify
  steam
  sublime-text
  telegram
  the-unarchiver
  tunnelblick
  vagrant
  virtualbox
  virtualbox-extension-pack
  visualvm
  vlc
  webstorm
  # Quick Look plugins
#  betterzipql
  qlcolorcode
#  qlimagesize
  qlmarkdown
  qlprettypatch
  qlstephen
  qlvideo
  quicklook-csv
  quicklook-json
  quicklookase
  quicknfo
  suspicious-package
  webpquicklook
  java8
  # Color pickers
  colorpicker-developer
  colorpicker-skalacolor
  # Drivers
  sonos
  # Fonts
  font-source-code-pro-for-powerline
)

# Install Homebrew casks.
casks=($(setdiff "${casks[*]}" "$(brew cask list 2>/dev/null)"))
if (( ${#casks[@]} > 0 )); then
  e_header "Installing Homebrew casks: ${casks[*]}"
  for cask in "${casks[@]}"; do
    brew cask install $cask
  done
  brew cleanup
fi

# Work around colorPicker symlink issue.
# https://github.com/caskroom/homebrew-cask/issues/7004
cps=()
for f in ~/Library/ColorPickers/*.colorPicker; do
  [[ -L "$f" ]] && cps=("${cps[@]}" "$f")
done

if (( ${#cps[@]} > 0 )); then
  e_header "Fixing colorPicker symlinks"
  for f in "${cps[@]}"; do
    target="$(readlink "$f")"
    e_arrow "$(basename "$f")"
    rm "$f"
    cp -R "$target" ~/Library/ColorPickers/
  done
fi
