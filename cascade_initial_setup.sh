#!/bin/bash

#
#
#
#

############### Constants ###############

PPAS=(
	"linuxuprising/java"
)

PKGS=(
	"sudo"
	"curl"
	"git"
	"nano"
	"nginx"
	"nodejs"
	"npm"
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

echo_green "Installing base packages!"
for pkg in "${PKGS[@]}"
do
	base_pkgs+="$pkg "
done
apt-get -y install $base_pkgs


echo_green "Installing Java 11!"
# Accept license for a silent install
echo debconf shared/accepted-oracle-license-v1-2 select true | debconf-set-selections 
echo debconf shared/accepted-oracle-license-v1-2 seen true | debconf-set-selections
apt-get -y install oracle-java11-installer oracle-java11-set-default

