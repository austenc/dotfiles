# Create a zsh script that does the above steps
echo "⏳ Installing dotfiles..."

# Install Antidote
echo "🧪 Installing Antidote (zsh plugin manager)..."
git clone --depth=1 https://github.com/mattmc3/antidote.git ${ZDOTDIR:-~}/.antidote

# Install dracula vim theme
echo "🧛🏻‍♂️ Installing Dracula Vim theme..."
mkdir -p ~/.vim/colors
curl https://raw.githubusercontent.com/dracula/vim/master/colors/dracula.vim -o ~/.vim/colors/dracula

# Create a symlink to the dotfiles
ln -s ~/Code/dotfiles/.zshrc ~/.zshrc
ln -s ~/Code/dotfiles/.vimrc ~/.vimrc

echo "✅ Dotfiles installed! Open a new terminal and run `p10k configure` to install fonts."
