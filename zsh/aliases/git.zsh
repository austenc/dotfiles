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
alias wip='git add . && git commit -m "wip" && pub'

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
# Delete any branches that have been merged into main
# See also: https://gist.github.com/robmiller/5133264
alias dmb="gco main && gb --merged | grep -v '\*' | xargs -n 1 git branch -d"

# Open pull request page for current branch (or specify with optional argument)
function gpr() {
    local branch_name=`git symbolic-ref HEAD 2>/dev/null | cut -d"/" -f 3`
    local repo_url=`git remote get-url origin | sed -e 's/git@//' -e 's/.git//' -e 's/:/\//'`
    open "https://$repo_url/compare/${1:-main}...$branch_name"
}

# Open the create issue page for this repo (with optional title)
function gis() {
    local repo_url=`git remote get-url origin | sed -e 's/git@//' -e 's/.git//' -e 's/:/\//'`
    open "https://$repo_url/issues/new?title=${1:-}"
}
