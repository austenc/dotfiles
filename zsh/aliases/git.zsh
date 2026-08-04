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

# Create a git worktree for a given branch name (run from the target repo)
function gwt() {
    if [[ -z "$1" ]]; then
        echo "Usage: gwt <branch-name>"
        return 1
    fi

    if ! git rev-parse --is-inside-work-tree >/dev/null 2>&1; then
        echo "[error] Not inside a git repository"
        return 1
    fi

    local branch="$1"
    local worktree_dir="${HOME}/Code/worktrees/$branch"

    if [[ -d "$worktree_dir" ]]; then
        echo "[worktree] Already exists: $worktree_dir"
        cd "$worktree_dir" || return 1
        return 0
    fi

    mkdir -p "${worktree_dir:h}" || return 1

    echo "[worktree] Adding branch: $branch"
    if git show-ref --verify --quiet "refs/heads/$branch"; then
        echo "[git] Using local branch"
        git worktree add "$worktree_dir" "$branch" || return 1
    elif git ls-remote --exit-code --heads origin "$branch" >/dev/null 2>&1; then
        echo "[git] Tracking remote branch"
        git worktree add --track -b "$branch" "$worktree_dir" "origin/$branch" || return 1
    else
        echo "[git] Creating branch from origin/develop"
        git worktree add -b "$branch" "$worktree_dir" origin/develop || return 1
    fi

    cd "$worktree_dir" || { echo "[error] Failed to cd into $worktree_dir"; return 1; }
}
