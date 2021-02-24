#!/bin/bash
SUDO=""

if [[ $EUID -ne 0 ]]; then
   SUDO='sudo'
fi

function get_pac_man() {
    declare -A osInfo;
    osInfo[/etc/debian_version]="${SUDO} apt update; ${SUDO} apt install -y ${1} ${2} ${3} ${4} ${5} ${6} ${7} ${8}"
    osInfo[/etc/alpine-release]="${SUDO} apk --update add ${1} ${2} ${3} ${4} ${5} ${6} ${7} ${8}"
    osInfo[/etc/centos-release]="${SUDO} yum update; ${SUDO} yum install -y  ${1} ${2} ${3} ${4} ${5} ${6} ${7} ${8}"
    osInfo[/etc/fedora-release]="${SUDO} dnf update; ${SUDO} dnf install -y  ${1} ${2} ${3} ${4} ${5} ${6} ${7} ${8}"

    for f in ${!osInfo[@]}
    do
        if [[ -f $f ]];then
            package_manager=${osInfo[$f]}
        fi
    done

    echo "${package_manager}"
}

### Installs oh-my-zsh, powerlevel10k theme, and plugins
function install() {
    #sh -c "$(curl -fsSL https://raw.github.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
    cd ~ && mkdir .zshinstall && cd .zshinstall
    wget https://raw.github.com/ohmyzsh/ohmyzsh/master/tools/install.sh
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
        echo "Installing on ${unameOut}"
        get_pac_man curl wget git zsh
        #"${cmd}" curl wget git zsh -y

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

