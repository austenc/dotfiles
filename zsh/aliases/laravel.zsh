# Laravel aliases
alias nrd='npm run dev'
alias nrw='npm run watch'
alias artisan='php artisan'
alias art='php artisan'
alias plz='php please'
alias lreset='rm -rf ./vendor && composer install && npm ci && npm run dev'
alias composer='COMPOSER_MEMORY_LIMIT=-1 composer'

# Require a package from a local folder
composer-link() {
    composer config repositories.local '{"type": "path", "url": "'$1'"}' --file composer.json
}

# Control multiple TMU instances
function tower() {
    php ~/Code/tower/artisan tower:$@
}

# Start a new laravel project with austencam/cable
function newapp() {
    composer create-project --prefer-dist laravel/laravel ${1:-newapp}
    cd ${1:-newapp}
    composer require austencam/cable
    php artisan cable:run
    cp .env.example .env
    php artisan key:generate
}

# Open dev setup for the current project / folder
function dev() {
    cd ~/Code/${1:-$PWD} && code .;
    if [ "$2" = "-w" ]; then
        npm run watch
    fi
}

function createdb() {
    mysql -uroot -e "create database if not exists ${1:laravel};"
}