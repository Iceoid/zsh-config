#!/bin/bash

unameOut="$(uname -s)"
case "${unameOut}" in
    Linux*)     
        machine=Linux
        sed -i 's/ZSH_THEME="robbyrussell"/ZSH_THEME="fino"/' ~/.zshrc
        ;;
    Darwin*)
        machine=Mac
        sed -i .bak 's/ZSH_THEME="robbyrussell"/ZSH_THEME="fino"/' ~/.zshrc
        ;;
    *)
        machine="OTHER:${unameOut}"
        ;;
esac

echo 'alias ll="ls -hal"' >> ~/.zshrc

function help() {
    echo "Changes the zsh theme and adds the ll alias. You can add other aliases as arguments to the script ie. (addzshconfig.sh 'alias l="ls -alh"')"
    echo
    echo "No other flags for now."
}
# ${@} for all arguments passed to the script. ${@:2:3} starts at the 2nd argument, and contains up to 3 args.
case "$1" in
    -h | --help)
        help
        ;;
    *)
        for arg in "${@}"; do
            echo "${arg}" >> test
        done
        ;;
esac