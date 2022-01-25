# Backups, swaps and undos are stored here.
mkdir -p $DOTFILES/caches/vim

plugins=(
  "vim-sensible|https://github.com/tpope/vim-sensible.git"
  "editorconfig-vim|https://github.com/editorconfig/editorconfig-vim.git"
  "vim-polyglot|https://github.com/sheerun/vim-polyglot.git"
  "vim-airline|https://github.com/vim-airline/vim-airline"
  "vim-checklist|https://github.com/evansalter/vim-checklist.git"
)

# Download Vim plugins.
if [[ "$(type -P vim)" ]]; then
  #vim +PlugUpgrade +PlugUpdate +qall
  # TODO: include installation of pathogen
  mkdir -p ~/.vim/autoload ~/.vim/bundle && \
  curl -LSso ~/.vim/autoload/pathogen.vim https://tpo.pe/pathogen.vim
fi

for p in "${plugins[@]}"; do
  name="$(echo "$p" | cut -d'|' -f 1)"
  url="$(echo "$p" | cut -d'|' -f 2)"
  echo "Installing $name from $url"
  if [ -d "$DOTFILES/link/.vim/bundle/$name" ]; then
    git -C "$DOTFILES/link/.vim/bundle/$name" pull
  else
    git clone "$url" "$DOTFILES/link/.vim/bundle/$name"
  fi
done
