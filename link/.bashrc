
#export CLICOLOR=1

#export LSCOLORS=GxFxCxDxBxegedabagaced

TITLEBAR_RESET="\[\e]1;\s\$ \W\a\e]2;\u@\h\a\]"
CUSTOM_PS1_PREFIX=$TITLEBAR_RESET"\[\033[36m\]\u\[\033[m\]@\[\033[32m\]\h"
CUSTOM_PS1_WD="\[\033[33;1m\]\w\[\033[m\]"
CUSTOM_PS1_WD_SHORT="\[\033[33;1m\]\W\[\033[m\]"
CUSTOM_SUFFIX="\$"

virtual_env_ps1() {
  if [ -n "$VIRTUAL_ENV" ]; then
    # PREFIX=$(basename $VIRTUAL_ENV)
    # if [ -n "$VENV_PROMPT" ]; then
    #     PREFIX=$(printf "$VENV_PROMPT" "$PREFIX")
    # else
    #     PREFIX="$PREFIX "
    # fi
    echo "(venv) "
  fi
}

ps1_assemble() {
  venv=$( virtual_env_ps1 )
  if [ -n "$venv" ]; then
    echo $venv$CUSTOM_PS1_PREFIX":"$CUSTOM_PS1_WD_SHORT
  else 
    echo $CUSTOM_PS1_PREFIX":"$CUSTOM_PS1_WD
  fi
}

ps1_suffix() {
  venv=$( virtual_env_ps1 )
  if [ -n "$venv" ]; then
    echo "\n"$CUSTOM_SUFFIX
  else 
    echo $CUSTOM_SUFFIX
  fi
}


export CLICOLOR=1
export LSCOLORS=ExFxBxDxCxegedabagacad

alias vi='/usr/local/bin/vim'
alias ls='ls -GFh'

export EDITOR=/usr/bin/vi

alias cd..='cd ../'                         # Go back 1 directory level (for fast typers)
alias ..='cd ../'                           # Go back 1 directory level
alias ...='cd ../../'                       # Go back 2 directory levels
alias .3='cd ../../../'                     # Go back 3 directory levels
alias .4='cd ../../../../'                  # Go back 4 directory levels
alias .5='cd ../../../../../'               # Go back 5 directory levels
alias .6='cd ../../../../../../'            # Go back 6 directory levels

alias less='less -FSRXc'                    # Preferred 'less' implementation
alias cp='cp -iv'                           # Preferred 'cp' implementation
alias mv='mv -iv'                           # Preferred 'mv' implementation
alias mkdir='mkdir -pv'                     # Preferred 'mkdir' implementation
trash () { command mv "$@" ~/.Trash ; }     # trash:        Moves a file to the MacOS trash
zipf () { zip -r "$1".zip "$1" ; }          # zipf:         To create a ZIP archive of a folder

#   showa: to remind yourself of an alias (given some part of it)
#   ------------------------------------------------------------
#   showa () { /usr/bin/grep --color=always -i -a1 $@ ~/Library/init/bash/aliases.bash | grep -v '^\s*$' | less -FSRXc ; }

#   extract:  Extract most know archives with one command
#   ---------------------------------------------------------
extract () {
  if [ -f $1 ] ; then
    case $1 in
      *.tar.bz2)   tar xjf $1     ;;
      *.tar.gz)    tar xzf $1     ;;
      *.bz2)       bunzip2 $1     ;;
      *.rar)       unrar e $1     ;;
      *.gz)        gunzip $1      ;;
      *.tar)       tar xf $1      ;;
      *.tbz2)      tar xjf $1     ;;
      *.tgz)       tar xzf $1     ;;
      *.zip)       unzip $1       ;;
      *.Z)         uncompress $1  ;;
      *.7z)        7z x $1        ;;
      *)     echo "'$1' cannot be extracted via extract()" ;;
       esac
   else
       echo "'$1' is not a valid file"
   fi
}

#   ---------------------------
#   4.  SEARCHING
#   ---------------------------

alias qfind="find . -name "                 # qfind:    Quickly search for file
ff () { /usr/bin/find . -name "$@" ; }      # ff:       Find file under the current directory
ffs () { /usr/bin/find . -name "$@"'*' ; }  # ffs:      Find file whose name starts with a given string
ffe () { /usr/bin/find . -name '*'"$@" ; }  # ffe:      Find file whose name ends with a given string

#   spotlight: Search for a file using MacOS Spotlight's metadata
#   -----------------------------------------------------------
spotlight () { mdfind "kMDItemDisplayName == '$@'wc"; }
search () { mdfind -onlyin "`pwd`" "$@" ; }



function mcd () #make dir and cd in
{
  command mkdir -p "$1" && cd "$1"
}


# tabtab source for yo package
# uninstall by removing these lines or running `tabtab uninstall yo`
[ -f /usr/local/lib/node_modules/yo/node_modules/tabtab/.completions/yo.bash ] && . /usr/local/lib/node_modules/yo/node_modules/tabtab/.completions/yo.bash

export PATH="$HOME/.config/yarn/global/node_modules/.bin:$PATH"
alias mvnpurge="mvn dependency:purge-local-repository"

export PATH="/usr/local/opt/python/libexec/bin:$PATH"

#alias i="idea $(pwd)"
export "ANDROID_HOME=$HOME/Library/Android/sdk"

# tabtab source for jhipster package
# uninstall by removing these lines or running `tabtab uninstall jhipster`
[ -f /Users/joshuawood/.config/yarn/global/node_modules/tabtab/.completions/jhipster.bash ] && . /Users/joshuawood/.config/yarn/global/node_modules/tabtab/.completions/jhipster.bash


push() { git push -u origin `git rev-parse --abbrev-ref HEAD`; }
checkout() { 
  if [ -z $1 ]
  then
    echo "Branch name is requried as the 1st parameter";
  else
    EXISTS=$(git branch | grep -w $1 | wc -l)
    if [ $EXISTS -eq 1 ]
    then
      git checkout $1
    else
      git checkout -b $1; 
    fi
  fi
}

if [ -d "$HOME/bin" ]; then
  export PATH="$PATH:$HOME/bin"
fi


export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion

isFunction() { [[ "$(declare -Ff "$1")" ]]; }
update_term_cwd_command() {
  if [ $TERM != "screen" ]
  then
    if [ $(isFunction "update_terminal_cwd") ]
    then
      echo "update_terminal_cwd"
    fi
  fi
}
screen_title_cmd() {
  local SCREENTITLE=''
	case $TERM in
    screen*)
      # This is the escape sequence ESC k ESC \
      $SCREENTITLE='\[\ek\w\e\\\]'
      ;;
    *)
      $SCREENTITLE=''
    ;;
	esac
  echo "$SCREENTITLE"
}

source ~/.git-prompt.sh
export PROMPT_COMMAND='__posh_git_ps1 "$(ps1_assemble)" " $(ps1_suffix) ";'$(update_term_cwd_command)

# tabtab source for serverless package
# uninstall by removing these lines or running `tabtab uninstall serverless`
[ -f $NVM_DIR/versions/node/v6.11.4/lib/node_modules/serverless/node_modules/tabtab/.completions/serverless.bash ] && . $NVM_DIR/versions/node/v6.11.4/lib/node_modules/serverless/node_modules/tabtab/.completions/serverless.bash
# tabtab source for sls package
# uninstall by removing these lines or running `tabtab uninstall sls`
[ -f $NVM_DIR/versions/node/v6.11.4/lib/node_modules/serverless/node_modules/tabtab/.completions/sls.bash ] && . $NVM_DIR/versions/node/v6.11.4/lib/node_modules/serverless/node_modules/tabtab/.completions/sls.bash


case "$OSTYPE" in
  solaris*) . $HOME/.solaris ;;
  darwin*)  . $HOME/.osx ;; 
  linux*)   . $HOME/.linux ;;
  bsd*)     . $HOME/.bsd ;;
  *)        echo "unknown: $OSTYPE" ;;
esac

if [ -f "$HOME/.secrets" ]; then
  . "$HOME/.secrets"
fi

# export TERM=”screen-256color”
# powerline-daemon -q
# POWERLINE_BASH_CONTINUATION=1
# POWERLINE_BASH_SELECT=1
# . /usr/local/lib/python3.7/site-packages/powerline/bindings/bash/powerline.sh
