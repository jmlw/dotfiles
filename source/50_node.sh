[[ "$1" != init && ! -e ~/.nvm ]] && return 1

export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh" # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion

#function nave_install() {
#  local version
#  [[ ! "$1" ]] && echo "Specify a node version or \"stable\"" && return 1
#  [[ "$1" == "stable" ]] && version=$(nave stable) || version=${1#v}
#  if [[ ! -d "${NAVE_DIR:-$HOME/.nave}/installed/$version" ]]; then
#    e_header "Installing Node.js $version"
#    nave install $version
#  fi
#  [[ "$1" == "stable" ]] && nave_default stable && npm_install
#}

function nvm_install() {
  curl -o- https://raw.githubusercontent.com/creationix/nvm/v0.34.0/install.sh | bash
  nvm install node # install latest
}
