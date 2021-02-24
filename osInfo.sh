#!/bin/bash
SUDO=""

if [[ $EUID -ne 0 ]]; then
   SUDO='sudo'
fi
function get_osInfo(){
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
cmd=$(get_osInfo)
$cmd curl
# echo $(get_osInfo)
# res=$(get_osInfo)
# echo $res
