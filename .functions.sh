#!/bin/bash
# Create a new directory and enter it
function md() {
	mkdir -p "$@" && cd "$@"
}


# find shorthand
function f() {
	find . -name "$1" 2>&1 | grep -v 'Permission denied'
}

# List all files, long format, colorized, permissions in octal
function la(){
 	ls -l  "$@" | awk '
    {
      k=0;
      for (i=0;i<=8;i++)
        k+=((substr($1,i+2,1)~/[rwx]/) *2^(8-i));
      if (k)
        printf("%0o ",k);
      printf(" %9s  %3s %2s %5s  %6s  %s %s %s\n", $3, $6, $7, $8, $5, $9,$10, $11);
    }'
}

cdf() {  # short for cdfinder
  cd "`osascript -e 'tell app "Finder" to POSIX path of (insertion location as alias)'`"
}

cp_p () {
  rsync -WavP --human-readable --progress "$1" "$2"
}

function localip(){
	function _localip(){ echo "📶  "$(ipconfig getifaddr "$1"); }
	export -f _localip
	local purple="\x1B\[35m" reset="\x1B\[m"
	networksetup -listallhardwareports | \
		sed -r "s/Hardware Port: (.*)/${purple}\1${reset}/g" | \
		sed -r "s/Device: (en.*)$/_localip \1/e" | \
		sed -r "s/Ethernet Address:/📘 /g" | \
		sed -r "s/(VLAN Configurations)|==*//g"
}

function csvpreview(){
      sed 's/,,/, ,/g;s/,,/, ,/g' "$@" | column -s, -t | less -#2 -N -S
}

function gcaa() {
  git add --all
  git commit -m "$*"
}


unalias gcf
function get_git_flow_prefix() { 
  prefix=`git config --get gitflow.prefix.$1` 
  if [[ -n $prefix  ]]; then
    echo "$prefix";
  else
    echo "$1/"
  fi
}
function gcf()  { git checkout "`get_git_flow_prefix feature`$1"; }
function gffs() { git flow feature start "$1"; }
function gfff() { git flow feature finish -F "$(git_flow_current_branch)"; }


function gch()  { git checkout "`get_git_flow_prefix hotfix`$1"; }
function gfhs() { git flow hotfix start "$1"; }
function gfhf() { git fetch --tags; git pull origin master; git flow hotfix finish -F "$(git_flow_current_branch)"; }

function gcr()  { git checkout "`get_git_flow_prefix release`$1";  }
function gfrs() { git flow release start "$1"; }
function gfrf() { git flow release finish -F "$(git_flow_current_branch)"; }

function git_flow_current_branch(){ git rev-parse --abbrev-ref HEAD | cut -d'/' -f 2; }


