###################
##   EXPORTS    ##
#################

export COMPOSER_HOME=~/.config/composer
export GREP_OPTIONS='--color=auto'
export EDITOR=nano

###################
##   OPTIONS    ##
#################

setopt autocd                   # Allow changing directories without `cd`
setopt append_history           # Do not overwrite history
setopt extended_history         # Also record time and duration of commands.
setopt share_history            # Share history between multiple shells
setopt hist_expire_dups_first   # Clear duplicates when trimming internal hist.
setopt hist_find_no_dups        # Do not display duplicates during searches.
setopt hist_ignore_dups         # Ignore consecutive duplicates.
setopt hist_ignore_all_dups     # Remember only one unique copy of the command.
setopt hist_reduce_blanks       # Remove superfluous blanks.
setopt hist_save_no_dups        # Omit older commands in favor of newer ones.

# Changing directories
setopt pushd_ignore_dups        # Do not push copies of the same dir on stack.
setopt pushd_minus              # Reference stack entries with '-'.
setopt extended_glob


###################
##    ALIAS     ##
#################

#source .whoNeedsInstalls

alias rm="rm -I"
alias df='df -h'                          # human-readable sizes
alias free='free -m'                      # show sizes in MB
alias np='nano -w PKGBUILD'
alias more=less
alias ..='cd ..'
alias ....='cd ../..'
alias ......='cd ../../..'
alias ls='ls -ahF --color=auto'
alias lt='exa -alhs size -SF --icons'

alias nuke='pkill -9'
alias please='sudo'
alias fucking='sudo'
alias ffs='sudo'

alias mypubip='curl ifconfig.co'
#  aka sleep 10; alert
alias alert='notify-send -i "$([ $? = 0 ] && (echo terminal; exit 0) || (echo error; exit 1))" "$([ $? = 0 ] && echo Task finished || echo Something went wrong!)" "$(history | sed -n "\$s/^\s*[0-9]\+\s*\(.*\)[;&|]\s*alert\$/\1/p")"'
# i'm a busy h4kk0r
alias busy="cat /dev/urandom | hexdump -C | grep 'ca fe'"
# Expand current directory structure in tree form
alias treed="ls -R | grep ":$" | sed -e 's/:$//' -e 's/[^-][^\/]*\//--/g' -e 's/^/   /' -e 's/-/|/'"
# i cant type
alias cd..="cd .."
alias cd.="cd .."
alias cd...="cd .."
# i.e nocomments /etc/php/php.ini
alias nocomments='grep "^[^#*/;]" $1'

alias fail="tail -f -n 150"
alias openconnections='netstat -tulanp '
alias exposedports="openconnections | grep LISTEN | awk '{ print \$4, \$7 }'"
alias deepnmap="nmap -Pn -A -T4"

alias sail='./sail'
alias art='./sail artisan'


###################
##  FUNCTIONS   ##
#################

#
# # ex - archive extractor
# # usage: ex <file>
extract ()
{
  if [ -f $1 ] ; then
    case $1 in
      *.tar.bz2)   tar xjf $1   ;;
      *.tar.gz)    tar xzf $1   ;;
      *.bz2)       bunzip2 $1   ;;
      *.rar)       unrar x $1     ;;
      *.gz)        gunzip $1    ;;
      *.tar)       tar xf $1    ;;
      *.tbz2)      tar xjf $1   ;;
      *.tgz)       tar xzf $1   ;;
      *.zip)       unzip $1     ;;
      *.Z)         uncompress $1;;
      *.7z)        7z x $1      ;;
      *)           echo "'$1' cannot be extracted via extract()" ;;
    esac
  else
    echo "'$1' is not a valid file"
  fi
}

compress() {
  if [[ -n "$1" ]]; then
    FILE=$1
    case $FILE in
      *.tar ) shift && tar cf $FILE $* ;;
      *.tar.bz2 ) shift && tar cjf $FILE $* ;;
      *.tar.gz ) shift && tar czf $FILE $* ;;
      *.tgz ) shift && tar czf $FILE $* ;;
      *.zip ) shift && zip $FILE $* ;;
      *.rar ) shift && rar $FILE $* ;;
    esac
  else
    echo "usage: compress <foo.tar.gz> ./foo ./bar"
  fi
}

mkcd() {
  if [ $# != 1 ]; then
    echo "Usage: mkcd <dir>"
  else
    mkdir -p $1 && cd $1
  fi
}

cacheclear() {
  if [[ -z $1 ]]; then
    days=100
  else
    days=$1
  fi
  find ~/.cache/ -type f -atime +"$days" -delete
}

etch() {
    if [ $# != 2 ];then
      echo "Usage: etch <SOURCE> <TARGET>"
    else
      sudo dd if="$1" of="$2" status=progress
    fi
}

# create quick backup of current file
backup() { cp "$1"{,.bak};}

fuck() {
  if [[ -z $1 ]]; then
    sudo $(!!)
  else
    sudo $@
  fi
}

weather() {
  curl http://wttr.in/$1
}
