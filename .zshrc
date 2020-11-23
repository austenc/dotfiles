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
for f in ~/Code/dotfiles/aliases/*; do
  source $f
done

# Include the Antibody plugin framework
source <(antibody init)

# Include the bundles from Antibody
# These are zsh plugins for the theme, extra completions, etc...
antibody bundle < .zsh_plugins

# Bind up and down keys to utilize substring searching for partial commands
# Similar to Ctrl+R, but easier -- via zsh-history-substring-search
bindkey '^[[A' history-substring-search-up
bindkey '^[[B' history-substring-search-down

# Enable vi mode when hitting escape
bindkey -v
