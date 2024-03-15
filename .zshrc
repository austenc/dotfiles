# Put homebrew in the application path
eval "$(/opt/homebrew/bin/brew shellenv)"

# Antidote (zsh plugin manager - https://getantidote.github.io/install)
source ${ZDOTDIR:-~}/.antidote/antidote.zsh
antidote load ~/Code/dotfiles/zsh/plugins.zsh ~/.zsh_plugins

# Pull in the powerlevel10k theme
source ~/Code/dotfiles/theme/theme.zsh

# Add composer vendor directory to the system path. This allows things globally
# installed with composer to be called, such as Laravel Valet.
export PATH=${PATH}:~/.composer/vendor/bin

# Include compinit so we can use extra completions
autoload -Uz compinit && compinit -C

# Pull in various aliases from the dotfiles repo
for f in ~/Code/dotfiles/zsh/aliases/*.zsh; do
  source $f
done

# Bind up and down keys to utilize substring searching for partial commands
# Similar to Ctrl+R, but easier -- via zsh-history-substring-search
bindkey '^[[A' history-substring-search-up
bindkey '^[[B' history-substring-search-down
bindkey 'ƒ' forward-word # option + f
bindkey '¬' forward-word # option + l
bindkey '∫' backward-word # option + b
bindkey '˙' backward-word # option + h

# Enable vi mode when hitting escape
bindkey -v

# Rebind terminal defaults (so vi mode doesn't take them over)
bindkey '^a' beginning-of-line
bindkey '^e' end-of-line
bindkey '^k' kill-line
bindkey '\e[3~' delete-char

# Set zsh-autosuggestions to use completion engine
typeset -ga ZSH_AUTOSUGGEST_STRATEGY=(history completion)
# Asynchronously gather suggestions so git clone isn't slow (and other http commands)
# This will be automatically enabled in the next version of zsh-autosuggestions:
# See here - https://github.com/zsh-users/zsh-autosuggestions/issues/566#issuecomment-705955104
typeset -gi ZSH_AUTOSUGGEST_USE_ASYNC=1

# DBNgin
export PATH=/Users/Shared/DBngin/mysql/8.0.33/bin:$PATH

# Laravel Herd
export PATH="/Users/austen/Library/Application Support/Herd/bin/":$PATH
export HERD_PHP_82_INI_SCAN_DIR="/Users/austen/Library/Application Support/Herd/config/php/82/"
[[ -f "/Applications/Herd.app/Contents/Resources/config/shell/zshrc.zsh" ]] && builtin source "/Applications/Herd.app/Contents/Resources/config/shell/zshrc.zsh"
