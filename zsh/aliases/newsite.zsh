function newsite() {
local sitename=${1:-newsite}
local password=${2:-password}
cd ~/Code

git clone git@github.com:austenc/firebird.git $sitename

cd $sitename && rm -rf .git
cp .env.example .env

# Setup the base theme
cd site/themes && mv firebird $sitename
cd $sitename
mv ./resources/css/firebird.css ./resources/css/$sitename.css
mv ./resources/js/firebird.js ./resources/js/$sitename.js
perl -i -pe "s/firebird/$sitename/g" webpack.mix.js    
perl -i -pe "s/firebird/$sitename/g" .gitignore
perl -i -pe "s/firebird/$sitename/g" meta.yaml

# Build assets and set this theme as default
npm i && npm run dev
echo "theme: $sitename" > ~/Code/$sitename/site/settings/theming.yaml

# Go to the site directory and open vscode
cd ~/Code/$sitename

## TO DO:
# Install Spock and configure it
# Base gitignore changes 
}
