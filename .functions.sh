cleanGitBranch() {
  git fetch -p
  for branch in $(git branch -vv | grep ': gone]' | awk '{print $1}'); do
    if [ "*" != "$branch" ]; then
      git branch -D "$branch";
    fi
  done
}


cdf() {  # short for cdfinder
  cd "$(osascript -e 'tell app "Finder" to POSIX path of (insertion location as alias)')" || exit
}

cp_p () {
  rsync -WavP --human-readable --progress "$1" "$2"
}

csvpreview(){
      sed 's/,,/, ,/g;s/,,/, ,/g' "$@" | column -s, -t | less -#2 -N -S
}

gcaa() {
  git add --all
  git commit -m "$*"
}


unalias gcf
get_git_flow_prefix() {
  prefix=$(git config --get gitflow.prefix."$1")
  # shellcheck disable=2039
  if [[ -n $prefix  ]]; then
    echo "$prefix";
  else
    echo "$1/"
  fi
}
gcf()  { git checkout "$(get_git_flow_prefix feature)$1"; }
gffs() { git flow feature start "$1"; }
gfff() { git flow feature finish -F "$(git_flow_current_branch)"; }


gch()  { git checkout "$(get_git_flow_prefix hotfix)$1"; }
gfhs() { git flow hotfix start "$1"; }

gcr()  { git checkout "$(get_git_flow_prefix release)$1";  }
gfrs() { git flow release start "$1"; }
gfrf() { git flow release finish -F "$(git_flow_current_branch)"; }

git_flow_current_branch(){ git rev-parse --abbrev-ref HEAD | cut -d'/' -f 2; }

if ! command -v pbcopy > /dev/null 2>&1; then
  pbcopy() {
    cat | nc -q1 localhost 2224
  }
fi

if command -v getent > /dev/null 2>&1; then
  getIp() {
    getent hosts "$1" | cut -d" " -f 1
  }

getHost() {
  getent hosts "$1" | cut -d" " -f 2
}
fi


hashifyAll() {
    for var in *
    do
      hashify "$var"
    done
  }

hashify() {
  for var in "$@"
  do
    fileName=$(hashFile "$var")
    mv "$var" "$fileName"
  done

}
