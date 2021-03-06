alias ..="cd .."
alias cd..="cd .."
alias ...="cd ../.."
alias ....="cd ../../.."
alias .....="cd ../../../.."
alias ~="cd ~" # `cd` is probably faster to type though
alias -- -="cd -"

colorflag="-G"
if gls --color > /dev/null 2>&1; then
  colorflag="--color=auto"
fi
if which gls > /dev/null 2>&1; then
  alias ls="gls -AFh --group-directories-first ${colorflag}"
else
  colorflag="--color"
  alias ls="ls -AFh ${colorflag}"
fi
hash gls >/dev/null 2>&1 || alias gls="ls"
alias lsd='ls -l | grep "^d"' # only directories

export CLICOLOR_FORCE=1
export CLICOLOR=1

# alias dig="dig +nocmd any +multiline +noall +answer"
alias wget="curl -O"

# Recursively delete `.DS_Store` files
alias cleanup_dsstore="find . -name '*.DS_Store' -type f -ls -delete"

alias diskspace_report="df -P -kHl"
alias free_diskspace_report="diskspace_report"

# Shortcuts
alias g="git"
alias v="vim"
alias ungz="gunzip -k"

# File size
alias fs="stat -f \"%z bytes\""

# Empty the Trash on all mounted volumes and the main HDD. then clear the useless sleepimage
alias emptytrash=" \
    sudo rm -rfv /Volumes/*/.Trashes; \
    rm -rfv ~/.Trash/*; \
    sudo rm -v /private/var/vm/sleepimage; \
    rm -rv \"/Users/paulirish/Library/Application Support/stremio/Cache\";  \
    rm -rv \"/Users/paulirish/Library/Application Support/stremio/stremio-cache\" \
"

# Update installed Ruby gems, Homebrew, npm, and their installed packages
alias brew_update="brew -v update; brew upgrade --force-bottle --cleanup; brew cleanup; brew cask cleanup; brew prune; brew doctor; npm-check -g -u"
alias update_brew_npm_gem='brew_update; npm install npm -g; npm update -g; sudo gem update --system; sudo gem update --no-document'



alias push="git push"

# git root
alias gr='[ ! -z `git rev-parse --show-cdup` ] && cd `git rev-parse --show-cdup || pwd`'

if which pygmentize > /dev/null; then
  alias gcat='pygmentize -O style=monokai -f console256 -g'
fi

alias dockerstopall="docker stop \$(docker ps -q)"
