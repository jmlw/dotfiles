#!/usr/bin/env bash
# Install nvm.

function nvm_install() {
  echo "Installing nvm using the curl install script. Also installing the latest node release"
  curl -o- https://raw.githubusercontent.com/creationix/nvm/v0.34.0/install.sh | bash
  nvm install node # install latest
}

if [[ ! -d "~/.nvm" ]]; then
  nvm_install
fi
