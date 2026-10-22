# --- Workbrew/Safechain Setup - DO NOT REMOVE ---
# Bypasses "Insecure Directory" errors caused by managed permissions. 
# Keep on top of .zshrc file. Please contact IT if any issues persist.
export ZSH_DISABLE_COMPFIX="true"
autoload -U compinit && compinit -u
# ------------------------------

# Startup config that should be applied regardless of shell
source "$HOME/.init"

source "$HOME/.safe-chain/scripts/init-posix.sh" # Safe-chain Zsh initialization script
