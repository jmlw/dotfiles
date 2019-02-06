paths=(
  ~/.local/bin
  $DOTFILES/bin
  /usr/local/bin
  /usr/bin
  /usr/sbin
)

#export PATH
#for p in "${paths[@]}"; do
#  [[ -d "$p" ]] && PATH="$p:$(path_remove "$p")"
#done
#unset p paths

#export PATH="/usr/bin:$PATH"
export PATH="$DOTFILES/bin:$PATH"
export PATH="/usr/local/bin:$PATH"

