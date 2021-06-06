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
	curl -o "${DOCKER_CONVENIENCE_SCRIPT}" https://get.docker.com/
}

aux_install_docker () {
	local READ_ANSWER=''

	if [ -e "${DOCKER_CONVENIENCE_SCRIPT}" -a -f "${DOCKER_CONVENIENCE_SCRIPT}" ] ; then
		read -n 2 -p "File ${DOCKER_CONVENIENCE_SCRIPT} already exists, do you want to replace it? [y/n] " READ_ANSWER
		if [ "x${READ_ANSWER}" = 'xy' ] ; then
			get_convenience_script
		fi
	else
		get_convenience_script
	fi
	sudo sh "${DOCKER_CONVENIENCE_SCRIPT}"
	sudo usermod --append --groups docker "${USER_NAME}"
}

install_docker () {
	local READ_ANSWER=''

	echo 'For mor details, see [Docker docs - Docker Engine - Installation per distro - Install on Debian # Install using the convenience script](https://docs.docker.com/engine/install/debian/#install-using-the-convenience-script)'
	if [ "x`which docker`" != 'x' ] ; then
		echo 'Docker engine appears to be already installed'
		echo 'To get informations about how to uninstall it, see:'
		echo '[Docker docs - Docker engine - Installation per distro - Install on Debian # Uninstall old versions](https://docs.docker.com/engine/install/debian/#uninstall-old-versions)'
		echo '[Docker docs - Docker engine - Installation per distro - Install on Debian # Uninstall Docker Engine](https://docs.docker.com/engine/install/debian/#uninstall-docker-engine)'
	else
		echo "User to be add to group docker: ${USER_NAME} (only root and that user will be able to run docker engine)"
		read -n 2 -p 'Is that all right? [y/n] ' READ_ANSWER
		if [ ! \( "x${READ_ANSWER}" = 'xy' \) ] ; then
			usage
		else
			aux_install_docker
			echo 'Docker engine installed'
			echo 'If you are new to Docker, it is strongly advised that you take a look at:'
			echo '[Docker docs - Docker engine - Optional post-installation steps # Manage Docker as a non-root user](https://docs.docker.com/engine/install/linux-postinstall/#manage-docker-as-a-non-root-user)'
			echo '[Docker docs - Command-line reference - Docker CLI (docker) - Docker run reference # USER](https://docs.docker.com/engine/reference/run/#user)'
			echo '[Docker docs - Develop with Docker - Build images - Dockerfile best practices](https://docs.docker.com/develop/develop-images/dockerfile_best-practices/)'
			echo '[Docker docs - Dockerfile reference # Usage](https://docs.docker.com/engine/reference/builder/#usage)'
			echo 'Proceed to logout/login to be able to run docker engine'
		fi
	fi
}

install_docker_compose () {
	local READ_ANSWER

	if [ "x`which docker-compose`" != 'x' ] ; then
		echo 'docker-compose appears to be already installed'
	else
		if [ "x`which pip3`" = 'x' ] ; then
			read -n 2 -p 'pip3 python package appears not to be installed on your computer, and is needed to install docker-compose, install pip3? [y/n] ' READ_ANSWER
			if [ "x${READ_ANSWER}" = 'xy' ] ; then
				sudo apt-get update && sudo apt-get install -y python3-pip
			fi
		fi
		python3 -m pip install -U pip
		pip3 install docker-compose
		echo 'docker-compose installed'
		echo 'If you are new to Docker, it is strongly advised that you take a look at:'
		echo '[Docker docs - Compose file reference - Version 3](https://docs.docker.com/compose/compose-file/compose-file-v3/#compose-file-structure-and-examples)'
	fi
}

main () {
	local READ_ANSWER=''

	READ_ANSWER='1'
	while [ "x${READ_ANSWER}" = 'x1' -o "x${READ_ANSWER}" = 'x2' ] ; do
		echo 'What action would you like to perform?'
		echo '1. Install Docker engine'
		echo '2. Install docker-compose'
		read -n 2 -p '[1/2/q] ' READ_ANSWER
		if [ "x${READ_ANSWER}" = 'x1' ] ; then
			install_docker
		elif [ "x${READ_ANSWER}" = 'x2' ] ; then
			install_docker_compose
		fi
	done
}

main
