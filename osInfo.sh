#!/bin/bash
SUDO=""

if [[ $EUID -ne 0 ]]; then
   SUDO='sudo'
fi
function get_osInfo(){
    declare -A osInfo;
    osInfo[/etc/debian_version]="${SUDO} apt update && ${SUDO} apt install -y"
    osInfo[/etc/alpine-release]="${SUDO} apk --update add"
    osInfo[/etc/centos-release]="${SUDO} yum update && ${SUDO} yum install -y"
    osInfo[/etc/fedora-release]="${SUDO} dnf update && ${SUDO} dnf install -y"

    for f in ${!osInfo[@]}
    do
        if [[ -f $f ]];then
            package_manager=${osInfo[$f]}
        fi
    done

    echo "${package_manager}"
}
echo $(get_osInfo)
# echo $(get_osInfo)
# res=$(get_osInfo)
# echo $res
