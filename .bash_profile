# The following lines were added by Docker Desktop to add commands to your PATH.
export PATH="$PATH:/Users/mmckenna/.docker/bin"
# End of Docker Desktop section.

source .shrc

[ -r .functions ] && source .functions

# Load some category scripts
for file in ~/.{aliases,bash_prompt}; do
	[ -r "$file" ] && [ -f "$file" ] && source "$file";
done;

[ -e .bash_secure ] && source .bash_secure 

#eval "$(rbenv init -)"

test -e "${HOME}/.iterm2_shell_integration.bash" && source "${HOME}/.iterm2_shell_integration.bash"

export PATH="$HOME/.cargo/bin:$PATH"

. "$HOME/.local/bin/env"
