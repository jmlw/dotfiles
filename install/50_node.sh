#!/usr/bin/env bash
# Install nvm.

function nvm_install() {
  curl -o- https://raw.githubusercontent.com/creationix/nvm/v0.34.0/install.sh | bash
  nvm install node # install latest
}

if [[ ! -d "~/.nvm" ]]; then
  nvm_install
fi
