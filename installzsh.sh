#!/bin/bash
SUDO=""

if [[ $EUID -ne 0 ]]; then
   SUDO='sudo'
fi

function update_packages() {
    declare -A osInfo;
    osInfo[/etc/debian_version]="apt-get update"
    osInfo[/etc/alpine-release]="apk update"
    osInfo[/etc/centos-release]="yum update"
    osInfo[/etc/fedora-release]="dnf update"

    for f in ${!osInfo[@]}
    do
        if [[ -f $f ]];then
            package_manager_cmd=${osInfo[$f]}
        fi
    done

    echo "${package_manager_cmd}"
}

function install_packages() {
    declare -A osInfo;
    osInfo[/etc/debian_version]="apt-get install -y"
    osInfo[/etc/alpine-release]="apk add"
    osInfo[/etc/centos-release]="yum install -y"
    osInfo[/etc/fedora-release]="dnf install -y"

    for f in ${!osInfo[@]}
    do
        if [[ -f $f ]];then
            package_manager_cmd=${osInfo[$f]}
        fi
    done

    echo "${package_manager_cmd}"
}

### Installs oh-my-zsh, powerlevel10k theme, and plugins
function install() {
    #sh -c "$(curl -fsSL https://raw.github.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
    cd ~ && mkdir .zshinstall && cd .zshinstall
    wget https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh
    sh install.sh --unattended
    cd .. && rm -R .zshinstall

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
        echo "Install script for ${unameOut}"

        ${SUDO} $(update_packages)
        ${SUDO} $(install_packages) curl wget git zsh -y

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

