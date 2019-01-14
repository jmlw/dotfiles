# Backups, swaps and undos are stored here.
mkdir -p $DOTFILES/caches/vim

# Download Vim plugins.
if [[ "$(type -P vim)" ]]; then
  #vim +PlugUpgrade +PlugUpdate +qall
  # TODO: include installation of pathogen
  mkdir -p ~/.vim/autoload ~/.vim/bundle && \
  curl -LSso ~/.vim/autoload/pathogen.vim https://tpo.pe/pathogen.vim
fi
