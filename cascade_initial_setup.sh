#!/bin/bash

#
#
#
#

############### Constants ###############

APPS=(
	"sudo"
	"curl"
	"git"
	"nano"
)

PPAS=(
	"linuxuprising/java"
)

########################################

function separator()
{
	echo -e "\e[1;32m------------------------------\e[0m"
}

function echo_green()
{
	separator
	echo -e "\e[1;32m$1\e[0m"
	separator
}

if (( EUID != 0 )); then
	echo -e "\e[1;31mThis script must be run as root!\e[0m"
	exit 1
fi

echo_green "Adding repositories!"
for ppa in "${PPAS[@]}"
do
	add-apt-repository -y ppa:$ppa
done

echo_green "Running apt update!"
apt-get -y update

echo_green "Running apt upgrade!"
apt-get -y upgrade


