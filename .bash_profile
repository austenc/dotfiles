# Powerline
# https://github.com/powerline/powerline
powerline-daemon -q
POWERLINE_BASH_CONTINUATION=1
POWERLINE_BASH_SELECT=1
. /usr/local/lib/python3.7/site-packages/powerline/bindings/bash/powerline.sh

# Add the global composer install directory to our PATH
export PATH=${PATH}:~/.composer/vendor/bin
export PATH=${PATH}:/usr/local/opt/mysql@5.7/bin

# Enable git autocomplete, first make sure homebrew is installed, 
# then run `brew install git bash-completion`
# make sure you do not miss the "git" part of the command!
. /usr/local/etc/bash_completion.d/git-completion.bash

# Pull in various bash aliases from the dotfiles repo
for f in ~/Code/dotfiles/aliases/*; do
   . $f
done

# Allow bash completion on above aliases
__git_complete gco _git_checkout
__git_complete gb _git_branch
__git_complete gm _git_merge
__git_complete gp _git_pull
__git_complete gpu _git_push
