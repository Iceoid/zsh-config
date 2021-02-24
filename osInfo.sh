#!/bin/bash

function get_osInfo(){
    declare -A osInfo;
    osInfo[/etc/debian_version]="apt-get install -y"
    osInfo[/etc/alpine-release]="apk --update add"
    osInfo[/etc/centos-release]="yum install -y"
    osInfo[/etc/fedora-release]="dnf install -y"

    for f in ${!osInfo[@]}
    do
        if [[ -f $f ]];then
            package_manager=${osInfo[$f]}
        fi
    done
    echo "${package_manager}"
}

echo $(get_osInfo)
# res=$(get_osInfo)
# echo $res
