# New init-scripts style configuration options
source .init

# Common values: linux, darwin, cygwin
isOs () { [[ $OSTYPE == *$1* ]]; }

[ -r .functions ] && source .functions

# Load some category scripts
for file in ~/.{aliases,bash_prompt}; do
	[ -r "$file" ] && [ -f "$file" ] && source "$file";
done;

[ -e .bash_secure ] && source .bash_secure 

test -e "${HOME}/.iterm2_shell_integration.bash" && source "${HOME}/.iterm2_shell_integration.bash"
