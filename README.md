# Dotfiles

My dotfiles for macOS.

### Installation

1. Clone this repo `git clone git@github.com:austenc/dotfiles.git`
2. Run `ln -s ~/Code/dotfiles/.zshrc ~/.zshrc` and `ln -s ~/Code/dotfiles/.vimrc ~/.vimrc`
3. Install [xoria256 vim theme](https://www.vim.org/scripts/script.php?script_id=2140) - download the latest version and put it in `~/.vim/colors/xoria256`
4. Install Antidote via `git clone --depth=1 https://github.com/mattmc3/antidote.git ${ZDOTDIR:-~}/.antidote`
5. Open a new terminal, Antidote should install plugins
6. Run `p10k configure` and install the suggested font.
7. Restart iTerm (the entire app)
