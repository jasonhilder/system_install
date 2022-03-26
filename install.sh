#!/bin/bash

set -eu -o pipefail # fail on error and report it, debug all lines

sudo -n true
test $? -eq 0 || exit 1 "you should have sudo privilege to run this script"

#DOTFILES
if [ ! -d ~/.dotfiles/ ]; then
    # Will enter here if $DIRECTORY exists, even if it contains spaces
   echo "exist"
   cd ~ && git clone git@github.com:jasonhilder/dotfiles.git
   mv ~/dotfiles ~/.dotfiles
   cd ~/.dotfiles && stow zsh/ tmux/ alacritty/ nvim/
   cd ~
   source ~/.zshrc && zshalias 
if

#ZSH && OH MY ZSH
if ! command -v zsh >/dev/null 2>&1
then
    echo ###################
    echo "installing zsh..."
    echo ###################
    echo
    
    sudo apt install -qq -y zsh    
fi

#RIPGREP
if ! command -v rg >/dev/null 2>&1
then
    echo ###################
    echo "installing ripgrep..."
    echo ###################
    echo 
    sudo apt install -y ripgrep
fi

#GNU STOW
if ! command -v stow &> /dev/null
then
    echo ###################
    echo "installing gnu stow..."
    echo ###################
    echo 
    sudo apt install stow -qq -y
fi

#XCLIP
if ! command -v xclip &> /dev/null
then
    echo ###################
    echo "installing xclip..."
    echo ###################
    echo 
    sudo apt install xclip -qq -y
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

#ALACRITTY
if ! command -v alacritty >/dev/null 2>&1
then
    echo ###################
    echo "installing alacritty..."
    echo ###################
    echo 
    sudo apt install -qq -y alacritty
fi

#TMUX
if ! command -v tmux >/dev/null 2>&1
then
    echo ###################
    echo "installing tmux..."
    echo ###################
    echo 
    sudo apt install -qq -y tmux
fi

#DOCKER
if ! command -v docker >/dev/null 2>&1
then
    echo ###################
    echo "installing docker..."
    echo ###################
    echo 

    sudo apt-get remove docker docker.io containerd runc

    sudo apt-get install \
    ca-certificates \
    curl \
    gnupg \
    lsb-release

    curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo gpg --dearmor -o /usr/share/keyrings/docker-archive-keyring.gpg
 
    echo \
  "deb [arch=$(dpkg --print-architecture) signed-by=/usr/share/keyrings/docker-archive-keyring.gpg] https://download.docker.com/linux/ubuntu \
  $(lsb_release -cs) stable" | sudo tee /etc/apt/sources.list.d/docker.list > /dev/null

    sudo apt update
    sudo apt-get install -y docker-ce docker-ce-cli containerd.io
    sudo groupadd docker
    sudo usermod -aG docker $USER
fi

#DOCKER COMPOSE
if ! command -v docker-compose &> /dev/null
then
    echo ###################
    echo "Installing docker-compose..."
    echo ###################
    echo 

    sudo curl -L "https://github.com/docker/compose/releases/download/1.29.2/docker-compose-$(uname -s)-$(uname -m)" -o /usr/local/bin/docker-compose

    sudo chmod +x /usr/local/bin/docker-compose
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

#NEOVIM
if ! command -v neovim &> /dev/null
then
    echo ###################
    echo "Installing neovim..."
    echo ###################
    echo 

    wget https://github.com/neovim/neovim/releases/latest/download/nvim.appimage -q --show-progress
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



#ANDROID STUDIO
#FLUTTER
#REACT NATIVE
#ZOLA
#MEGA