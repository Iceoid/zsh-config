#!/bin/bash
SUDO=""

if [[ $EUID -ne 0 ]]; then
   SUDO='sudo'
fi

### Installs oh-my-zsh, powerlevel10k theme, and plugins
function install() {
    #sh -c "$(curl -fsSL https://raw.github.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
    mkdir .zshinstall && cd .zshinstall
    wget https://raw.github.com/ohmyzsh/ohmyzsh/master/tools/install.sh
    sh install.sh --unattended
    cd ..

    git clone --depth=1 https://github.com/romkatv/powerlevel10k.git ${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/themes/powerlevel10k
    sed -i 's/ZSH_THEME="robbyrussell"/ZSH_THEME="powerlevel10k\/powerlevel10k"/' ~/.zshrc
    echo 'alias ll="ls -hal"' >> ~/.zshrc
    echo "typeset -g POWERLEVEL9K_TRANSIENT_PROMPT=same-dir" >> ~/.p10k.zsh
    git clone https://github.com/zsh-users/zsh-syntax-highlighting.git ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-syntax-highlighting
    git clone https://github.com/zsh-users/zsh-autosuggestions ${ZSH_CUSTOM:-~/.oh-my-zsh/custom}/plugins/zsh-autosuggestions
    sed -i 's/plugins=(git)/plugins=( git zsh-syntax-highlighting zsh-autosuggestions )/' ~/.zshrc

    chsh -s $(which zsh)
    zsh

}

### Independent steps depending on platform
unameOut="$(uname -s)"
case "${unameOut}" in
    Linux*)     
        machine=Linux
        echo "Installing on ${unameOut}"

        ${SUDO} apt update
        ${SUDO} apt install curl wget git zsh -y

        mkdir -p ~/.local/share/fonts && \
        cd ~/.local/share/fonts && \
        curl -L -O https://github.com/romkatv/powerlevel10k-media/raw/master/MesloLGS%20NF%20Regular.ttf && \
        curl -L -O https://github.com/romkatv/powerlevel10k-media/raw/master/MesloLGS%20NF%20Bold.ttf &&\
        curl -L -O https://github.com/romkatv/powerlevel10k-media/raw/master/MesloLGS%20NF%20Italic.ttf && \
        curl -L -O https://github.com/romkatv/powerlevel10k-media/raw/master/MesloLGS%20NF%20Bold%20Italic.ttf

        install

        source ~/.zshrc
        ;;
    Darwin*)
        machine=Mac
        echo "Installing on ${unameOut}"

        install
        ;;
    *)
        machine="OTHER:${unameOut}"
        echo "Platform unsupported. (${unameOut})"
        ;;
esac

