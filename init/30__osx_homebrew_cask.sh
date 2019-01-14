# OSX-only stuff. Abort if not OSX.
is_osx || return 1

# Exit if Homebrew is not installed.
[[ ! "$(type -P brew)" ]] && e_error "Brew casks need Homebrew to install." && return 1

# Ensure the cask kegs are installed.
kegs=(
  caskroom/cask
  caskroom/drivers
  caskroom/fonts
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
  arial
  boostnote
  chromium
  datagrip
  disk-inventory-x
  docker
  docker-compose
  dropbox
  etcher
  filezilla
  firefox
  gitter
  google-chrome
  hermes
  insomnia-x
  intellij-idea
  iterm2
  java
  jd-gui
  licecap
  macdown
  macvim
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
  betterzipql
  qlcolorcode
  qlimagesize
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
  # Color pickers
  colorpicker-developer
  colorpicker-skalacolor
  # Drivers
  sonos
  # Fonts
)

# Install Homebrew casks.
casks=($(setdiff "${casks[*]}" "$(brew cask list 2>/dev/null)"))
if (( ${#casks[@]} > 0 )); then
  e_header "Installing Homebrew casks: ${casks[*]}"
  for cask in "${casks[@]}"; do
    brew cask install $cask
  done
  brew cask cleanup
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