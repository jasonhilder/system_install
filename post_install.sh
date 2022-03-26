#!/bin/bash

#DDEV
if ! command -v ddev &> /dev/null
then
    echo ###################
    echo "Installing ddev deps"
    echo ###################
    echo 

    sudo apt install libnss3-tools -qq -y
fi

#LAZYGIT
if ! command -v lg &> /dev/null
then
    echo ###################
    echo "Installing lazygit..."
    echo ###################
    echo 
	
    tag=$(curl --silent https://api.github.com/repos/jesseduffield/lazygit/releases/latest | grep -Po '"tag_name": "\K.*?(?=")')

    echo $tag

    VERSION=$(echo $tag|cut -c 2-6)
    FILE="lazygit_"$VERSION"_Linux_x86_64.tar.gz"

    download="https://github.com/jesseduffield/lazygit/releases/download/"$tag"/"$FILE
    wget -O $FILE $download

fi

#LAZYDOCKER
if ! command -v lazydocker &> /dev/null
then
    echo ###################
    echo "Installing lazydocker..."
    echo ###################
    echo 
	
    tag=$(curl --silent https://api.github.com/repos/jesseduffield/lazydocker/releases/latest | grep -Po '"tag_name": "\K.*?(?=")')

    echo $tag

    VERSION=$(echo $tag|cut -c 2-6)
    FILE="lazydocker_"$VERSION"_Linux_x86_64.tar.gz"

    download="https://github.com/jesseduffield/lazydocker/releases/download/"$tag"/"$FILE
    wget -O $FILE $download

fi

#OH MY ZSH
    chsh -s $(which zsh)
    echo installing oh my zsh
    sh -c "$(curl -fsSL https://raw.github.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
    echo installing zsh auto suggestion plugin
    git clone https://github.com/zsh-users/zsh-autosuggestions.git $ZSH_CUSTOM/plugins/zsh-autosuggestions
    echo installing zsh syntax highlighting plugin
    git clone https://github.com/zsh-users/zsh-syntax-highlighting.git $ZSH_CUSTOM/plugins/zsh-syntax-highlighting
