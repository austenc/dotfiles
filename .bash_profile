# Powerline
# https://github.com/powerline/powerline
powerline-daemon -q
POWERLINE_BASH_CONTINUATION=1
POWERLINE_BASH_SELECT=1
source /usr/local/lib/python3.7/site-packages/powerline/bindings/bash/powerline.sh

# Add the global composer install directory to our PATH
export PATH=${PATH}:~/.composer/vendor/bin
export PATH=${PATH}:/usr/local/opt/mysql@5.7/bin

# Enable git autocomplete, first make sure homebrew is installed, 
# then run `brew install git bash-completion`
# make sure you do not miss the "git" part of the command!
source /usr/local/etc/bash_completion.d/git-completion.bash

# Directory / Navigation aliases
alias ..='cd ..'
alias ...='cd ../..'
alias core='cd ~/Code/bedrock/core'
alias 406io='cd ~/Code/406io'
alias ccl='cd ~/Code/ccl/web/app/themes/crystalcreek'
alias venv='python3 -m venv venv'
alias act='. venv/bin/activate'
alias pytest='python3 -m unittest'

# Laravel aliases
alias nrd='npm run dev'
alias artisan='php artisan'
alias art='php artisan'
alias lreset='rm -rf ./vendor && composer install && npm ci && npm run dev'
alias tower='php ~/Code/tower/tower'

# Git command aliases
alias gac='git add . && git commit'
alias gs='git status'
alias gl='echo "Showing last 12 commits..." && git log --oneline --max-count="12"'
alias gd='git diff'
alias gc='git commit'
alias ga='git add'
alias gp='git pull'
alias gb='git branch'
alias gpu='git push'
alias gm='git merge'
alias gco='git checkout'
alias phpunit='vendor/bin/phpunit'
alias nah='git reset --hard && git clean -df'

# Allow bash completion on above aliases
__git_complete gco _git_checkout
__git_complete gb _git_branch
__git_complete gm _git_merge
__git_complete gp _git_pull
__git_complete gpu _git_push

# Some more Git aliases from https://gist.github.com/robmiller/6018582
# Get the current branch name (not so useful itself, but used in other aliases): 
alias branch-name='git rev-parse --abbrev-ref HEAD'
# Push the current branch to the remote "origin", and set it to track
# the upstream branch
function pub {
    [[ $(git config branch.$(git symbolic-ref --short HEAD).merge) = '' ]] && git push -u origin $(git symbolic-ref --short HEAD) || git push
}

# Delete the remote version of the current branch
alias unpub='git push origin :$(branch-name)'
# Unstage any files that have been added to the staging area
alias unstage='git reset HEAD'
# Delete any branches that have been merged into master
# See also: https://gist.github.com/robmiller/5133264
alias dmb="gco master && gb --merged | grep -v '\*' | xargs -n 1 git branch -d"

# Open dev setup for the current project / folder
function dev() {
    cd ~/Code/${1:-$PWD} && code . && npm run watch;
}

# Open pull request page for current branch (or specify with optional argument)
function gpr() {
    local branch_name=`git symbolic-ref HEAD 2>/dev/null | cut -d"/" -f 3`
    local repo_url=`git remote get-url origin | sed -e 's/git@//' -e 's/.git//' -e 's/:/\//'`
    open "https://$repo_url/compare/${1:-master}...$branch_name"
}

# Open the github for this repo
function gh() {
    local repo_url=`git remote get-url origin | sed -e 's/git@//' -e 's/.git//' -e 's/:/\//'`
    open "https://$repo_url"
}


# Open the create issue page for this repo (with optional title)
function gis() {
    local repo_url=`git remote get-url origin | sed -e 's/git@//' -e 's/.git//' -e 's/:/\//'`
    open "https://$repo_url/issues/new?title=${1:-}"
}

# Start a new laravel project with austenc/preset
function newapp() {
    composer create-project laravel/laravel ${1:-newapp} --prefer-dist
    cd ${1:-newapp}
    composer require austenc/preset --dev
    art preset austencam
    npm i && npm run dev
}

# Function to quickly bootstrap a new statamic site
. ~/Code/dotfiles/.newsite
