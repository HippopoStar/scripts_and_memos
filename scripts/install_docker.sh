#!/bin/bash

DOCKER_CONVENIENCE_SCRIPT='/tmp/get_docker.sh'
USER_NAME="`whoami`"

usage () {
	echo "${0}"
	echo 'Make sure to lauch this script as the user you wish to add to group docker, otherwise that user will not be able to run docker engine'
}

get_convenience_script () {
	local READ_ANSWER=''

	if [ "x`which curl`" = 'x' ] ; then
		read -n 2 -p 'curl package appears not to be installed on your computer, and is needed to download a convenience script in order to install docker engine, install curl? [y/n] ' READ_ANSWER
		if [ "x${READ_ANSWER}" = 'xy' ] ; then
			sudo apt-get update && sudo apt-get install -y curl
		fi
	fi
	curl -o ${DOCKER_CONVENIENCE_SCRIPT} https://get.docker.com/
}

install_docker () {
	local READ_ANSWER=''

	if [ -e ${DOCKER_CONVENIENCE_SCRIPT} -a -f ${DOCKER_CONVENIENCE_SCRIPT} ] ; then
		read -n 2 -p "File ${DOCKER_CONVENIENCE_SCRIPT} already exists, do you want to replace it? [y/n] " READ_ANSWER
		if [ "x${READ_ANSWER}" = 'xy' ] ; then
			get_convenience_script
		fi
	else
		get_convenience_script
	fi
	sudo sh ${DOCKER_CONVENIENCE_SCRIPT}
	sudo adduser --group docker ${USER_NAME}
}

main () {
	local READ_ANSWER=''

	echo 'For mor details, see [Docker docs - Docker Engine - Installation per distro - Install on Debian # Install using the convenience script](https://docs.docker.com/engine/install/debian/#install-using-the-convenience-script)'
	if [ "x`which docker`" != 'x' ] ; then
		echo 'Docker engine appears to be already install'
	else
		echo "User to be add to group docker: ${USER_NAME} (only root and that user will be able to run docker engine)"
		read -n 2 -p 'Is that all right? [y/n] ' READ_ANSWER
		if [ ! \( "x${READ_ANSWER}" = 'xy' \) ] ; then
			usage
		else
			install_docker
			echo 'Docker engine installed'
			echo 'Proceed to logout/login to be able to run docker engine'
		fi
	fi
}

main
