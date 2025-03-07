alias cursor='code'

function upgrade-tmu() {
    # Only do this if we're not already on the branch
    if [[ $(git branch --show-current) != "tmu-828-launch-core-version-20" ]]; then
        git checkout -b tmu-828-launch-core-version-20
    fi

    git pull upstream main

    # If there are any git conflicts, stop here
    if [[ $(git status | grep "Unmerged paths") ]]; then
        echo "There are git conflicts. Please resolve them before continuing."
        return 1
    fi

    composer require hdmaster/core:^20.0

    composer update
}
