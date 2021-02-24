#!/bin/bash
SUDO=""

if [[ $EUID -ne 0 ]]; then
   SUDO='sudo'
fi

unameOut="$(uname -s)"
case "${unameOut}" in
    Linux*)     
        machine=Linux
        ${SUDO} apt update
        ${SUDO} apt install curl zsh -y
        sh -c "$(curl -fsSL https://raw.github.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
        ;;
    Darwin*)
        machine=Mac
        sh -c "$(curl -fsSL https://raw.github.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
        ;;
    *)
        machine="OTHER:${unameOut}"
        ;;
esac
echo ${machine}