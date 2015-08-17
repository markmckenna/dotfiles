# Common values: linux, darwin, cygwin
isOs () { [[ $OSTYPE == *$1* ]]; }

[ -r .functions ] && source .functions
[ -r .exports ] && source .exports
[ -r .path ] && source .path

shopt -s nocaseglob; # Case-insensitive globbing (used in pathname expansion)
shopt -s histappend; # Append to the Bash history file, rather than overwriting it
shopt -s cdspell; # Autocorrect typos in path names when using `cd`

# Enable some Bash 4 features when possible:
# * `autocd`, e.g. `**/qux` will enter `./foo/bar/baz/qux`
# * Recursive globbing, e.g. `echo **/*.txt`
for option in autocd globstar; do
	shopt -s "$option" 2> /dev/null;
done;

# Add tab completion for many Bash commands
[ -r /etc/bash_completion ] && source /etc/bash_completion

# Enable tab completion for `g` by marking it as an alias for `git`
if type _git &> /dev/null && [ -f /usr/local/etc/bash_completion.d/git-completion.bash ]; then
	complete -o default -o nospace -F _git g;
fi;

# Add tab completion for SSH hostnames based on ~/.ssh/config, ignoring wildcards
[ -e "$HOME/.ssh/config" ] && complete -o "default" -o "nospace" -W "$(grep "^Host" ~/.ssh/config | grep -v "[?*]" | cut -d " " -f2- | tr ' ' '\n')" scp sftp ssh;

if [ -f ~/.git-completion.bash ]; then
  . ~/.git-completion.bash
fi

# Load platform-specific scripts
case $OSTYPE in
    darwin*)
        source `dirname $BASH_SOURCE`/.bash_profile_darwin
        ;;
    cygwin*)
        source `dirname $BASH_SOURCE`/.bash_profile_cygwin
        ;;
esac

# Load some category scripts
for file in ~/.{bash_prompt,aliases,extra}; do
	[ -r "$file" ] && [ -f "$file" ] && source "$file";
done;

[ -e .bash_secure ] && source .bash_secure 
