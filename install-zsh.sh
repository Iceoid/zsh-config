#!/bin/bash
SUDO=""

if [[ $EUID -ne 0 ]]; then
   SUDO='sudo'
fi

function install_oh-my-zsh() {
    sh -c "$(curl -fsSL https://raw.github.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
    sed -i 's/ZSH_THEME="robbyrussell"/ZSH_THEME="fino"/' ~/.zshconfig
    echo 'alias ll="ls -hal"' >> ~/.zshconfig
}

unameOut="$(uname -s)"
case "${unameOut}" in
    Linux*)     
        machine=Linux
        ${SUDO} apt update
        ${SUDO} apt install curl zsh -y
        install_oh-my-zsh
        ;;
    Darwin*)
        machine=Mac
        install_oh-my-zsh
        ;;
    *)
        machine="OTHER:${unameOut}"
        ;;
esac
echo ${machine}