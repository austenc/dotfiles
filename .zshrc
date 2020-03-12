# Powerline
# https://github.com/powerline/powerline
. /usr/local/lib/python3.7/site-packages/powerline/bindings/zsh/powerline.zsh

# Add the global composer install directory to our PATH
export PATH=${PATH}:~/.composer/vendor/bin
export PATH=${PATH}:/usr/local/opt/mysql@5.7/bin

# Enable git autocomplete, first make sure homebrew is installed, 
# then run `brew install git zsh-completion`
# make sure you do not miss the "git" part of the command!
if type brew &>/dev/null; then
  FPATH=$(brew --prefix)/share/zsh/site-functions:$FPATH

  autoload -Uz compinit
  compinit
fi

# Pull in various bash aliases from the dotfiles repo
for f in ~/Code/dotfiles/aliases/*; do
   . $f
done