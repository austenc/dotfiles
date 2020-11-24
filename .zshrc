# Pull in the powerlevel10k theme
source ~/Code/dotfiles/theme/theme.zsh

# Run a given command with the x86 architecture flag.
# Useful for installing things that aren't yet ARM-compatible with Rosetta 2.
x86() {
  arch -x86_64 $@
}

# Add composer vendor directory to the system path. This allows things globally 
# installed with composer to be called, such as Laravel Valet.
export PATH=${PATH}:~/.composer/vendor/bin

# Include compinit so we can use extra completions
autoload -Uz compinit && compinit -C

# Pull in various aliases from the dotfiles repo
for f in ~/Code/dotfiles/zsh/aliases/*.zsh; do
  source $f
done

# Include the compiled Antibody plugins
# These are zsh plugins for the theme, extra completions, etc...
# To edit the plugins, change zsh/plugins.zsh and run ./build.sh
source ~/Code/dotfiles/zsh/plugins_compiled.zsh

# Bind up and down keys to utilize substring searching for partial commands
# Similar to Ctrl+R, but easier -- via zsh-history-substring-search
bindkey '^[[A' history-substring-search-up
bindkey '^[[B' history-substring-search-down

# Enable vi mode when hitting escape
bindkey -v

# Rebind terminal defaults (so vi mode doesn't take them over)
bindkey '^a' beginning-of-line
bindkey '^e' end-of-line
bindkey '^k' kill-line

# Set zsh-autosuggestions to use completion engine
typeset -ga ZSH_AUTOSUGGEST_STRATEGY=(history completion)