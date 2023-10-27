#!/bin/zsh

# Install Antidote
if [ ! -d "${ZDOTDIR:-~}/.antidote" ]; then
    echo "\033[1;32m🧪  Installing Antidote (zsh plugin manager)...\033[0m"
    git clone --depth=1 https://github.com/mattmc3/antidote.git ${ZDOTDIR:-~}/.antidote
else
    echo "\033[1;32m🧪  Antidote already installed!\033[0m"
fi

# Install dracula vim theme
if [ ! -d ~/.vim/pack/themes/start/dracula ]; then
    echo "\033[1;32m🧛🏻  Installing Dracula Vim theme...\033[0m"
    mkdir -p ~/.vim/pack/themes/start
    git clone https://github.com/dracula/vim.git ~/.vim/pack/themes/start/dracula
else
    echo "\033[1;32m🧛🏻  Dracula Vim theme already installed!\033[0m"
fi

# Create a symlink to the dotfiles
if [ ! -L ~/.zshrc ]; then
    ln -s ~/Code/dotfiles/.zshrc ~/.zshrc
    echo "\033[1;32m🔗  Created symbolic link for .zshrc\033[0m"
fi

if [ ! -L ~/.vimrc ]; then
    ln -s ~/Code/dotfiles/.vimrc ~/.vimrc
    echo "\033[1;32m🔗  Created symbolic link for .vimrc\033[0m"
fi

echo "\033[1;32m✅  Dotfiles installed! Open a new terminal and run 'p10k configure' to install fonts.\033[0m"
