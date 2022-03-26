#!/bin/bash

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
    cd ~ && wget -O $FILE $download

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
    cd ~ && wget -O $FILE $download

fi

#DDEV
if ! command -v ddev &> /dev/null
then
    echo ###################
    echo "Installing ddev deps"
    echo ###################
    echo 
	
    cd ~ && curl -LO https://raw.githubusercontent.com/drud/ddev/master/scripts/install_ddev.sh && bash install_ddev.sh
    sudo apt install libnss3-tools -qq -y
    sudo wget https://github.com/FiloSottile/mkcert/releases/download/v1.4.3/mkcert-v1.4.3-linux-amd64 -O /usr/local/bin/mkcert
    sudo chmod a+x /usr/local/bin/mkcert
    mkcert -install
fi

#VOLTA(nodejs)
if ! command -v volta >/dev/null 2>&1
then
    echo ###################
    echo "installing volta..."
    echo ###################
    echo 
    curl https://get.volta.sh | bash
fi

#RUST
if ! command -v rustup &> /dev/null
then
    echo ###################
    echo "Installing rust..."
    echo ###################
    echo 

    curl --proto '=https' --tlsv1.2 -sSf https://sh.rustup.rs | sh
fi

#TRANSMISSION
if ! command -v transmission >/dev/null 2>&1
then
    echo ###################
    echo "installing transmission..."
    echo ###################
    echo 

    sudo apt install -y transmission
fi

#GOOGLE
if ! command -v google-chrome >/dev/null 2>&1
then
    echo ###################
    echo "installing google chrome..."
    echo ###################
    echo 

    sudo apt install -y google-chrome-stable
fi

#OH MY ZSH
if [ ! -d ~/.oh-my-zsh/ ]; then
    echo installing zsh auto suggestion plugin
    git clone https://github.com/zsh-users/zsh-autosuggestions.git $ZSH_CUSTOM/plugins/zsh-autosuggestions
    echo installing zsh syntax highlighting plugin
    git clone https://github.com/zsh-users/zsh-syntax-highlighting.git $ZSH_CUSTOM/plugins/zsh-syntax-highlighting
    chsh -s $(which zsh)
    echo installing oh my zsh
    sh -c "$(curl -fsSL https://raw.github.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
fi

#ANDROID STUDIO
#FLUTTER
#REACT NATIVE
#MEGA 
#ZOLA
