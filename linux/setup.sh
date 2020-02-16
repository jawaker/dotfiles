#!/bin/bash

# STEP 1: Symlink dotfiles
echo "=================================================="
echo "Linking your dotfiles to your home directory..."
echo "=================================================="
ln -s -f "$PWD/.gemrc"                 ~/.gemrc
ln -s -f "$PWD/.rspec"                 ~/.rspec
ln -s -f "$PWD/vimrc"                  ~/.vimrc
ln -s -f "$PWD/vimrc.bundles"          ~/.vim/.bundles
ln -s -f "$PWD/vimrc.commands"         ~/.vim/.commands
ln -s -f "$PWD/vimrc.mappings"         ~/.vim/.mappings
ln -s -f "$PWD/vimrc.plugin.options"   ~/.vim/.plugin.options


VIM_VERSION=$(vim --version | grep -o 'IMproved 8\.[0-9]')
if [[ $VIM_VERSION == "" ]]; then
  echo "=================================================="
  echo "Installing VIM 8.1"
  echo "=================================================="
  sudo add-apt-repository ppa:jonathonf/vim
  sudo apt-get update
  sudo apt-get install vim
  echo "Installed VIM 8.1"
else
  echo "=================================================="
  echo "VIM 8.1 already installed"
  echo "=================================================="
fi

exit

# STEP 4: Install oh-my-zsh
echo "=================================================="
echo "STEP 4:"
echo "oh-my-zsh setup..."
echo "=================================================="

if [ ! -d ~/.oh-my-zsh ]
then
  echo "Downloading oh-my-zsh..."
  git clone git://github.com/robbyrussell/oh-my-zsh.git ~/.oh-my-zsh
  sh -c "$(curl -fsSL https://raw.githubusercontent.com/robbyrussell/oh-my-zsh/master/tools/install.sh)"
  echo "Download complete!"
else
  echo "oh-my-zsh already setup..."
fi
echo

# STEP 5: Install Custom oh-my-zsh themes
echo "=================================================="
echo "STEP 5:"
echo "Install Custom themes for zsh"
echo "=================================================="

if [ ! -f ~/.oh-my-zsh/custom/themes/spaceship.zsh-theme ]
then
  curl -o - https://raw.githubusercontent.com/denysdovhan/spaceship-zsh-theme/master/install.zsh | zsh
  echo "Your zsh theme has been changed to Spaceship"
else
  echo "Spaceship already installed"
fi
echo

if [ ! -f ~/.oh-my-zsh/custom/themes/powerlevel9k ]
then
  git clone https://github.com/bhilburn/powerlevel9k.git ~/.oh-my-zsh/custom/themes/powerlevel9k
  echo "Powelevel9k installed"
else
  echo "Powelevel9k already installed"
fi
echo

# STEP 6: Change default shell to zsh
echo "=================================================="
echo "STEP 6:"
echo "Default shell to zsh..."
echo "=================================================="

if [ "$(echo $SHELL)" = "/bin/zsh" ]
then
  echo "Your default shell is already zsh"
else
  echo "Changing your default shell to zsh..."
  chsh -s /bin/zsh
  echo "Your default shell is now zsh"
fi;
echo

# STEP 7: Create an empty .env and .zshrc.local files
echo "=================================================="
echo "STEP 7:"
echo "Create a empty .env and .zshrc.local files"
echo "=================================================="

if [ ! -f ~/.env ]
then
  echo "Creating an empty file to place your ENV variables..."
  touch ~/.env
  echo "File created!"
else
  echo ".env file already present!"
fi
echo

if [ ! -f ~/.zshrc.local ]
then
  echo "Creating an empty file to place your local zsh config..."
  touch ~/.zshrc.local
  echo "File created!"
else
  echo ".zshrc.local file already present!"
fi
echo

# STEP 8: Install Vundle package manager for vim
echo "=================================================="
echo "STEP 8:"
echo "Install Vundle for vim"
echo "=================================================="

if [ ! -d ~/.vim/bundle/Vundle.vim ]
then
  echo "Downloading Vundle..."
  git clone https://github.com/VundleVim/Vundle.vim.git ~/.vim/bundle/Vundle.vim
  echo "Download complete!"
  echo

  echo "Installing vim plugins..."
  vim +PluginInstall +qall
  echo "Installation complete!"
else
  echo "Vundle installed!"
  vim +PluginClean +PluginInstall +qall
fi
echo

# STEP 9: Add custom fonts
echo "=================================================="
echo "STEP 9:"
echo "Adding custom fonts to Font Book"
echo "=================================================="

if [ ! -f ~/Library/Fonts/Droid_Sans_Mono_for_Powerline.otf ]
then
  echo "Adding Droid Sans Mono..."
  sudo cp ~/workspace/dotfiles/fonts/Droid_Sans_Mono_for_Powerline.otf ~/Library/Fonts/Droid_Sans_Mono_for_Powerline.otf
fi

if [ ! -f ~/Library/Fonts/FiraCode-Retina.ttf ]
then
  echo "Adding Fira Code..."
  sudo cp ~/workspace/dotfiles/fonts/FiraCode-Retina.ttf ~/Library/Fonts/FiraCode-Retina.ttf
fi

if [ ! -f ~/Library/Fonts/Meslo_LG_L_DZ_Regular_Nerd_Font_Complete.otf ]
then
  echo "Adding Meslo (Nerd Font)..."
  sudo cp ~/workspace/dotfiles/fonts/Meslo_LG_L_DZ_Regular_Nerd_Font_Complete.otf ~/Library/Fonts/Meslo_LG_L_DZ_Regular_Nerd_Font_Complete.otf
fi

if [ ! -f ~/Library/Fonts/Lato-Regular.ttf ]
then
  echo "Adding Lato..."
  sudo cp ~/workspace/dotfiles/fonts/Lato-Regular.ttf ~/Library/Fonts/Lato-Regular.ttf
fi

echo "Please restart your terminal and select a font from the preferences of your favourite Terminal"
echo

# STEP 10: Setup rbenv
echo "=================================================="
echo "STEP 10:"
echo "Setting up rbenv"
echo "=================================================="

if [ -d ~/.rbenv ]
then
  echo "Setting up rbenv..."
  rbenv init
  echo
  echo "Please restart your terminal"
else
  echo "rbenv already setup!"
fi
echo

# STEP 11: Install Tmux package manager tpm
echo "=================================================="
echo "STEP 11:"
echo "Setting up Tmux package manager"
echo "=================================================="

if [ ! -d ~/.tmux/plugins/tpm ]
then
  echo "Downloading tpm..."
  git clone https://github.com/tmux-plugins/tpm ~/.tmux/plugins/tpm
  echo "Download complete!"
  echo "Please start a tmux session and enter CTRL-A + I to install the packages"
else
  echo "tpm already installed!"
fi
echo

# STEP 12: Setup Node Version Manager (nvm)
echo "=================================================="
echo "STEP 12:"
echo "Setting up Node Version Manager (nvm)"
echo "=================================================="

if [ ! -d ~/.nvm ]
then
  echo "Setting up nvm..."
  curl -o- https://raw.githubusercontent.com/creationix/nvm/v0.31.11/install.sh | bash
  echo
  echo "Please restart your terminal"
else
  echo "nvm already setup!"
fi
echo
