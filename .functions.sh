cleanGitBranch() {
  git fetch -p
  for branch in $(git branch -vv | grep ': gone]' | awk '{print $1}'); do
    if [ "*" != "$branch" ]; then
      git branch -D "$branch";
    fi
  done
}


cp_p () {
  rsync -WavP --human-readable --progress "$1" "$2"
}

csvpreview(){
      sed 's/,,/, ,/g;s/,,/, ,/g' "$@" | column -s, -t | less -#2 -N -S
}

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
