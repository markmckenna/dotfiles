# Common values: linux, darwin, cygwin
isOs () { [[ $OSTYPE == *$1* ]]; }

export PATH="$HOME/bin:$PATH"

# Load the shell dotfiles, and then some:
# * ~/.path can be used to extend `$PATH`.
# * ~/.extra can be used for other settings you don’t want to commit.
for file in ~/.{path,bash_prompt,exports,aliases,functions,extra}; do
	[ -r "$file" ] && [ -f "$file" ] && source "$file";
done;
unset file;

# Case-insensitive globbing (used in pathname expansion)
shopt -s nocaseglob;

# Append to the Bash history file, rather than overwriting it
shopt -s histappend;

# Autocorrect typos in path names when using `cd`
shopt -s cdspell;

# Enable some Bash 4 features when possible:
# * `autocd`, e.g. `**/qux` will enter `./foo/bar/baz/qux`
# * Recursive globbing, e.g. `echo **/*.txt`
for option in autocd globstar; do
	shopt -s "$option" 2> /dev/null;
done;

# Add tab completion for many Bash commands
[ -f /etc/bash_completion ] && source /etc/bash_completion

# Enable tab completion for `g` by marking it as an alias for `git`
if type _git &> /dev/null && [ -f /usr/local/etc/bash_completion.d/git-completion.bash ]; then
	complete -o default -o nospace -F _git g;
fi;

# Add tab completion for SSH hostnames based on ~/.ssh/config, ignoring wildcards
[ -e "$HOME/.ssh/config" ] && complete -o "default" -o "nospace" -W "$(grep "^Host" ~/.ssh/config | grep -v "[?*]" | cut -d " " -f2- | tr ' ' '\n')" scp sftp ssh;

export MAVEN_OPTS="-Xms512m -Xmx1g -XX:PermSize=64m -XX:MaxPermSize=256m -Djava.awt.headless=true"
export CLICOLOR=true

# git macros
alias gitconfig='vim ~/.gitconfig'
alias fetch='git fetch --tags --prune'
alias merge='git merge --no-ff'
alias push='git push'
alias status='git status'
alias lol='git lol'
alias vlol='git vlol'
alias branch='git branch'
alias checkout='git checkout'
alias reset='git reset'
alias stash='git stash'
alias commit='git commit'
alias pull='git pull'
alias add='git add'

# src macros
alias gsource='cd ~/Documents/Viacom/VMNVideoPlayer-Android-Source'
alias gsample='cd ~/Documents/Viacom/VMNVideoPlayer-Android-Sample-App'
alias gtestrig='cd ~/Documents/Viacom/VMNVideoPlayer-Android-TestRig'
alias gharness='cd ~/Documents/Viacom/VMNVideoPlayer-Android-TestHarness'
alias gcomedy='cd ~/Documents/Viacom/CCNetworkAndroid'
alias gbento='cd ~/Documents/Viacom/Bento-Android-Lib'

function removeFromPath() {  
  export PATH=$(echo $PATH | sed -E -e "s;:$1;;" -e "s;$1:?;;")  
}

if [ -f ~/.git-completion.bash ]; then
  . ~/.git-completion.bash
fi

export IDEA_JDK=$JAVA_HOME

[ -f .bash_profile_${OSTYPE} ] && source .bash_profile_${OSTYPE}
