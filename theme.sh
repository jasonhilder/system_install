#!/bin/bash
echo "Install all options or select? [y/n]"
echo ""
echo "Note: If you type n (no) you will be asked before each install to proceed."

read _override

if [[ $_override = "y" ]]; then
    _proceed="y"
fi

#MAKE DIRS FOR THEME
if [[ ! -d "${HOME}/.icons" ]]; then
    mkdir ~/.icons
fi

if [[ ! -d "${HOME}/.themes" ]]; then
    mkdir ~/.themes
fi

#OH MY ZSH PLUGINS
if [[ ! -d ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions ]]; then
    echo "installing zsh auto suggestion plugin..."
    git clone https://github.com/zsh-users/zsh-autosuggestions ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions
fi

if [[ ! -d ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting ]]; then
    echo "installing zsh syntax highlighting plugin..."
    git clone https://github.com/zsh-users/zsh-syntax-highlighting.git ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting
fi

#SPACE MONO FONT
font="Space Mono Nerd Font"
fc-list -q "$font"
if [ $? -eq 0 ]
then
    echo "Space Mono Nerd Font found on system moving on..."
else
    echo "Adding font to system..."

    echo "Downloading Space Mono Nerd Font..."
    wget "https://github.com/ryanoasis/nerd-fonts/releases/download/v2.1.0/SpaceMono.zip" -q --show-progress

    if [ -d $HOME"/.fonts/" ]; then
        unzip -q "./SpaceMono.zip" -d $HOME"/.fonts/"
    else
       mkdir -p $HOME"/.fonts/"
       unzip -q "./SpaceMono.zip" -d $HOME"/.fonts/"
    fi

    echo "Cleaning up download..."
    rm -rf "./SpaceMono.zip"
fi

#CATPPUCCIN GTK THEME
if [[ ! $_override = "all" ]]; then
    echo "Install catppucin blue theme? [y/n]"
    read _proceed
fi

if [[ $_proceed = "y" ]]; then
    if [[ ! -d "${HOME}/.themes/Catppuccin-blue" ]]; then
        tag=$(curl --silent https://api.github.com/repos/catppuccin/gtk/releases/latest | grep -Po '"tag_name": "\K.*?(?=")')

        echo $tag

        VERSION=$(echo $tag|cut -c 2-6)
        FILE="Catppuccin-blue.zip"

        download="https://github.com/catppuccin/gtk/releases/download/"$tag"/"$FILE
        cd ~ && wget -O $FILE $download -q --show-progress
    else
        echo "Theme already installed..."
    fi
else
    echo "As you wish"
fi

#PAPIRUS ICONS
if [[ ! $_override = "all" ]]; then
    echo "Install Papirus Icon theme? [y/n]"
    read _proceed
fi

if [[ $_proceed = "y" ]]; then
    if [[ ! -d "${HOME}/.icons/Papirus" ]]; then
        wget -qO- https://git.io/papirus-icon-theme-install | DESTDIR="$HOME/.icons" sh
    else
        echo "Icons already installed..."
    fi
fi

#REFRESH ZSHRC && ALIASES
cd ~ && rm .zshrc
cd ~/.dotfiles && stow zsh/
