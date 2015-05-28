export PATH=/usr/local/bin:$PATH:/Development/android-sdk-macosx/platform-tools

# Add `~/bin` to the `$PATH`
export PATH="$HOME/bin:$PATH";

export ANDROID_HOME=/Development/android-sdk-macosx

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
if which brew > /dev/null && [ -f "$(brew --prefix)/share/bash-completion/bash_completion" ]; then
	source "$(brew --prefix)/share/bash-completion/bash_completion";
elif [ -f /etc/bash_completion ]; then
	source /etc/bash_completion;
fi;

# Enable tab completion for `g` by marking it as an alias for `git`
if type _git &> /dev/null && [ -f /usr/local/etc/bash_completion.d/git-completion.bash ]; then
	complete -o default -o nospace -F _git g;
fi;

# Add tab completion for SSH hostnames based on ~/.ssh/config, ignoring wildcards
[ -e "$HOME/.ssh/config" ] && complete -o "default" -o "nospace" -W "$(grep "^Host" ~/.ssh/config | grep -v "[?*]" | cut -d " " -f2- | tr ' ' '\n')" scp sftp ssh;

# Add tab completion for `defaults read|write NSGlobalDomain`
# You could just use `-g` instead, but I like being explicit
complete -W "NSGlobalDomain" defaults;

# Add `killall` tab completion for common apps
complete -o "nospace" -W "Contacts Calendar Dock Finder Mail Safari iTunes SystemUIServer Terminal Twitter" killall;

export MAVEN_OPTS="-Xms512m -Xmx1g -XX:PermSize=64m -XX:MaxPermSize=256m -Djava.awt.headless=true"
export CLICOLOR=true
export PATH=$PATH:/Development/jad158g.mac.intel:~/bin

alias bashrc='vim ~/.bashrc && source ~/.bashrc'

# bash macros
alias bashrc='vim ~/.bashrc && source ~/.bashrc'

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

alias java='java -Dapple.awt.UIElement=true'

# src macros
alias gsource='cd ~/Documents/Viacom/VMNVideoPlayer-Android-Source'
alias gsample='cd ~/Documents/Viacom/VMNVideoPlayer-Android-Sample-App'
alias gtestrig='cd ~/Documents/Viacom/VMNVideoPlayer-Android-TestRig'
alias gharness='cd ~/Documents/Viacom/VMNVideoPlayer-Android-TestHarness'
alias gcomedy='cd ~/Documents/Viacom/CCNetworkAndroid'
alias gbento='cd ~/Documents/Viacom/Bento-Android-Lib'

function decompile() {
  local OLDJDK=`getjdk`
  setjdk 1.8
  java -jar ~/bin/jd-core-java-1.2.jar $1.jar $1
  setjdk $OLDJDK
}

# tool macros
function decompile-maven() {
  local PATH=~/.m2/repository/$1/$2/$3

  pushd $PATH

  if [ $? -ne 0 ]; then
    echo "No such Maven entry found at $PATH"
    return
  fi

  decompile $2-$3
  jar -cf $2-$3-sources.jar -C $2-$3 *

  popd
}

function setjdk() {  
  if [ $# -ne 0 ]; then  
   removeFromPath '/System/Library/Frameworks/JavaVM.framework/Home/bin'  
   if [ -n "${JAVA_HOME+x}" ]; then  
    removeFromPath $JAVA_HOME/bin  
   fi  
   export JAVA_HOME=`/usr/libexec/java_home -v $@`  
   export PATH=$JAVA_HOME/bin:$PATH  
  fi  
}  

function getjdk() {
  echo $(which java | egrep -o '1\.[0-9]')
}

function removeFromPath() {  
  export PATH=$(echo $PATH | sed -E -e "s;:$1;;" -e "s;$1:?;;")  
}

if [ -f ~/.git-completion.bash ]; then
  . ~/.git-completion.bash
fi

setjdk 1.7

export IDEA_JDK=$JAVA_HOME
