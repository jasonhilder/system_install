#!/bin/bash

#MAKE DIRS FOR THEME
mkdir ~/.icons
mkdir ~/.themes

#OH MY ZSH PLUGINS
echo "installing zsh auto suggestion plugin..."
git clone https://github.com/zsh-users/zsh-autosuggestions ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions
echo "installing zsh syntax highlighting plugin..."
git clone https://github.com/zsh-users/zsh-syntax-highlighting.git ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting

#HACK FONT
font="Hack Nerd Font"
fc-list -q "$font"
if [ $? -eq 0 ]
then
    echo "Hack Font found on system moving on..."
else
    echo "Adding font to system..."

    echo "Downloading Hack Nerdfont..."
    wget "https://github.com/ryanoasis/nerd-fonts/releases/download/v2.1.0/Hack.zip" -q --show-progress

    if [ -d $HOME"/.fonts/" ]; then
        unzip -q "./Hack.zip" -d $HOME"/.fonts/"
    else
       mkdir -p $HOME"/.fonts/"
       unzip -q "./Hack.zip" -d $HOME"/.fonts/"
    fi

    echo "Cleaning up download..."
    rm -rf "./Hack.zip"
fi

echo -e "\n"

#GNOME TWEAKS
if ! command -v gnome-tweaks &> /dev/null
then
    echo ###################
    echo "Installing gnome tweaks..."
    echo ###################
    echo 

    sudo apt install gnome-tweaks -y
fi

#REFRESH ZSHRC && ALIASES
cd ~ && rm .zshrc
cd ~/.dotfiles && stow zsh/
cd ~ && source ~/.zshrc && zshalias
