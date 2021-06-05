#!/bin/bash

aux_stop_running_containers () {
	local READ_ANSWER=''

	if [ ${#} -eq 1 ] ; then
		read -n 2 -p "Would you like to stop container [${1}]? [y/n] " READ_ANSWER
		if [ "x${READ_ANSWER}" = 'xy' ] ; then
			docker stop "${1}"
		fi
	fi
}

stop_running_containers () {
	local RUNNING_CONTAINERS="`docker ps --filter "status=running" | awk 'NR > 1 { print $NF }'`"
	local LINE=''
	local -a ARRAY=()
	local ARRAY_LENGTH=0
	local ITERATOR=0
	local ELEMENT=''

	if [ "x${RUNNING_CONTAINERS}" = 'x' ] ; then
		echo 'No currently running container(s)'
	else
		echo 'Currently running container(s):'
		echo "${RUNNING_CONTAINERS}"
		while IFS= read -r LINE
		do
			ARRAY[${ARRAY_LENGTH}]="${LINE}"
			ARRAY_LENGTH=$((ARRAY_LENGTH + 1))
		done <<< "${RUNNING_CONTAINERS}"
		#echo "RUNNING_CONTAINER(S)_ARRAY: ${ARRAY[@]}"
		while [ ${ITERATOR} -lt ${ARRAY_LENGTH} ] ; do
			aux_stop_running_containers "${ARRAY[${ITERATOR}]}"
			ITERATOR=$((ITERATOR + 1))
		done
	fi
}

aux_remove_exited_containers () {
	local READ_ANSWER=''

	if [ ${#} -eq 1 ] ; then
		read -n 2 -p "Would you like to remove container [${1}]? [y/n] " READ_ANSWER
		if [ "x${READ_ANSWER}" = 'xy' ] ; then
			docker rm "${1}"
		fi
	fi
}

remove_exited_containers () {
	# https://docs.docker.com/engine/reference/commandline/ps/#filtering
	local EXITED_CONTAINERS="`docker ps --filter "status=exited" | awk 'NR > 1 { print $NF }'`"
	local LINE=''
	local -a ARRAY=()
	local ARRAY_LENGTH=0
	local ITERATOR=0
	local ELEMENT=''

	if [ "x${EXITED_CONTAINERS}" = 'x' ] ; then
		echo 'No exited container(s)'
	else
		echo 'Exited container(s):'
		echo "${EXITED_CONTAINERS}"
		while IFS= read -r LINE
		do
			ARRAY[${ARRAY_LENGTH}]="${LINE}"
			ARRAY_LENGTH=$((ARRAY_LENGTH + 1))
		done <<< "${EXITED_CONTAINERS}"
		#echo "EXITED_CONTAINER(S)_ARRAY: ${ARRAY[@]}"
		while [ ${ITERATOR} -lt ${ARRAY_LENGTH} ] ; do
			aux_remove_exited_containers "${ARRAY[${ITERATOR}]}"
			ITERATOR=$((ITERATOR + 1))
		done
	fi
}

aux_remove_docker_images () {
	local READ_ANSWER=''

	if [ ${#} -eq 1 ] ; then
		read -n 2 -p "Would you like to remove docker image [${1}]? [y/n] " READ_ANSWER
		if [ "x${READ_ANSWER}" = 'xy' ] ; then
			docker image rm "${1}"
		fi
	fi
}

remove_docker_images () {
	local DOCKER_IMAGES="`docker image ls | awk 'NR > 1 { print $1":"$2 }'`"
	local LINE=''
	local -a ARRAY=()
	local ARRAY_LENGTH=0
	local ITERATOR=0
	local ELEMENT=''

	if [ "x${DOCKER_IMAGES}" = 'x' ] ; then
		echo 'No docker image(s)'
	else
		echo 'Docker image(s):'
		echo "${DOCKER_IMAGES}"
		# Following commented block of code is from a first draft,
		# and was not kept due to security issues it can engender
		#for ELEMENT in ${DOCKER_IMAGES} ; do
		#	aux_remove_docker_images "${ARRAY[${ITERATOR}]}"
		#done
		while IFS= read -r LINE
		do
			ARRAY[${ARRAY_LENGTH}]="${LINE}"
			ARRAY_LENGTH=$((ARRAY_LENGTH + 1))
		done <<< "${DOCKER_IMAGES}"
		#echo "DOCKER_IMAGE(S)_ARRAY: ${ARRAY[@]}"
		while [ ${ITERATOR} -lt ${ARRAY_LENGTH} ] ; do
			aux_remove_docker_images "${ARRAY[${ITERATOR}]}"
			ITERATOR=$((ITERATOR + 1))
		done
	fi
}

aux_remove_docker_volumes () {
	local READ_ANSWER=''

	if [ ${#} -eq 1 ] ; then
		read -n 2 -p "Would you like to remove docker volume [${1}]? [y/n] " READ_ANSWER
		if [ "x${READ_ANSWER}" = 'xy' ] ; then
			docker volume rm "${1}"
		fi
	fi
}

remove_docker_volumes () {
	local DOCKER_VOLUMES="`docker volume ls | awk 'NR > 1 { print $2 }'`"
	local LINE=''
	local -a ARRAY=()
	local ARRAY_LENGTH=0
	local ITERATOR=0
	local ELEMENT=''

	if [ "x${DOCKER_VOLUMES}" = 'x' ] ; then
		echo 'No docker volume(s)'
	else
		echo 'Docker volume(s):'
		echo "${DOCKER_VOLUMES}"
		echo 'Too see docker s volumes along with their respective disk usage, open a new terminal and run `sudo ls --size --human-readable --format=single-column /var/lib/docker/volumes/`'
		while IFS= read -r LINE
		do
			ARRAY[${ARRAY_LENGTH}]="${LINE}"
			ARRAY_LENGTH=$((ARRAY_LENGTH + 1))
		done <<< "${DOCKER_VOLUMES}"
		#echo "DOCKER_VOLUME(S)_ARRAY: ${ARRAY[@]}"
		while [ ${ITERATOR} -lt ${ARRAY_LENGTH} ] ; do
			aux_remove_docker_volumes "${ARRAY[${ITERATOR}]}"
			ITERATOR=$((ITERATOR + 1))
		done
	fi
}

main () {
	echo "To fast clear your docker environnement from its containers, images and volumes, run this script the following way: \`yes | ${0}\`"
	echo 'If you deployed a docker constellation from docker-compose, make sure you executed `docker-compose down` before running this script'
	stop_running_containers
	remove_exited_containers
	remove_docker_images
	remove_docker_volumes
}

main
