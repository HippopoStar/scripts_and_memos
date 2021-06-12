#!/bin/bash

declare COLOR_BLACK='\033[30m'
declare COLOR_RED='\033[31m'
declare COLOR_GREEN='\033[32m'
declare COLOR_YELLOW='\033[33m'
declare COLOR_BLUE='\033[34m'
declare COLOR_MAGENTA='\033[35m'
declare COLOR_CYAN='\033[36m'
declare COLOR_WHITE='\033[37m'

declare COLOR_BRIGHT='\033[01m'
declare EOC='\033[00m'

declare COMMAND_COLOR="`echo "${COLOR_YELLOW}"`"

aux_stop_running_containers () {
	local READ_ANSWER=''
	local TARGET_ID=''

	if [ ${#} -eq 1 ] ; then
		echo -e "Would you like to ${COLOR_BRIGHT}stop${EOC} the following ${COLOR_BRIGHT}container${EOC}:"
		read -n 2 -p "[${1}]? [y/n] " READ_ANSWER
		if [ "x${READ_ANSWER}" = 'xy' ] ; then
			TARGET_ID="`echo "${1}" | awk '{ print $1 }'`"
			docker container stop "${TARGET_ID}"
		fi
	fi
}

stop_running_containers () {
	local DOCKER_COMMAND='docker container ls --filter status=running'
	local DOCKER_COMMAND_RETURN_VALUE="`${DOCKER_COMMAND}`"
	local DOCKER_COMMAND_RETURN_VALUE_HEADLESS="`echo "${DOCKER_COMMAND_RETURN_VALUE}" | tail --lines=+2`"
	local LINE=''
	local -a LINES_ARRAY=()
	local ARRAY_LENGTH=0
	local ITERATOR=0

	echo -e "${COMMAND_COLOR}${DOCKER_COMMAND}${EOC}"
	echo "${DOCKER_COMMAND_RETURN_VALUE}"
	echo ''
	if [ ! \( "x${DOCKER_COMMAND_RETURN_VALUE_HEADLESS}" = 'x' \) ] ; then
		while IFS= read -r LINE
		do
			LINES_ARRAY[${ARRAY_LENGTH}]="${LINE}"
			ARRAY_LENGTH=$((ARRAY_LENGTH + 1))
		done <<< "${DOCKER_COMMAND_RETURN_VALUE_HEADLESS}"
		#echo "RUNNING_CONTAINER(S)_ARRAY: ${LINES_ARRAY[@]}"
		while [ ${ITERATOR} -lt ${ARRAY_LENGTH} ] ; do
			aux_stop_running_containers "${LINES_ARRAY[${ITERATOR}]}"
			ITERATOR=$((ITERATOR + 1))
		done
	fi
}

aux_remove_exited_containers () {
	local READ_ANSWER=''
	local TARGET_ID=''

	if [ ${#} -eq 1 ] ; then
		echo -e "Would you like to ${COLOR_BRIGHT}remove${EOC} the following ${COLOR_BRIGHT}container${EOC}:"
		read -n 2 -p "[${1}]? [y/n] " READ_ANSWER
		if [ "x${READ_ANSWER}" = 'xy' ] ; then
			TARGET_ID="`echo "${1}" | awk '{ print $1 }'`"
			docker container rm "${TARGET_ID}"
		fi
	fi
}

remove_exited_containers () {
	# https://docs.docker.com/engine/reference/commandline/ps/#filtering
	local DOCKER_COMMAND='docker container ls --filter status=exited'
	local DOCKER_COMMAND_RETURN_VALUE="`${DOCKER_COMMAND}`"
	local DOCKER_COMMAND_RETURN_VALUE_HEADLESS="`echo "${DOCKER_COMMAND_RETURN_VALUE}" | tail --lines=+2`"
	local LINE=''
	local -a LINES_ARRAY=()
	local ARRAY_LENGTH=0
	local ITERATOR=0

	echo -e "${COMMAND_COLOR}${DOCKER_COMMAND}${EOC}"
	echo "${DOCKER_COMMAND_RETURN_VALUE}"
	echo ''
	if [ ! \( "x${DOCKER_COMMAND_RETURN_VALUE_HEADLESS}" = 'x' \) ] ; then
		while IFS= read -r LINE
		do
			LINES_ARRAY[${ARRAY_LENGTH}]="${LINE}"
			ARRAY_LENGTH=$((ARRAY_LENGTH + 1))
		done <<< "${DOCKER_COMMAND_RETURN_VALUE_HEADLESS}"
		#echo "EXITED_CONTAINER(S)_ARRAY: ${LINES_ARRAY[@]}"
		while [ ${ITERATOR} -lt ${ARRAY_LENGTH} ] ; do
			aux_remove_exited_containers "${LINES_ARRAY[${ITERATOR}]}"
			ITERATOR=$((ITERATOR + 1))
		done
	fi
}

aux_remove_docker_images () {
	local READ_ANSWER=''
	local TARGET_ID=''

	if [ ${#} -eq 1 ] ; then
		echo -e "Would you like to ${COLOR_BRIGHT}remove${EOC} the following ${COLOR_BRIGHT}image${EOC}:"
		read -n 2 -p "[${1}]? [y/n] " READ_ANSWER
		if [ "x${READ_ANSWER}" = 'xy' ] ; then
			TARGET_ID="`echo "${1}" | awk '{ print $3 }'`"
			docker image rm "${TARGET_ID}"
		fi
	fi
}

remove_docker_images () {
	local DOCKER_COMMAND='docker image ls'
	local DOCKER_COMMAND_RETURN_VALUE="`${DOCKER_COMMAND}`"
	local DOCKER_COMMAND_RETURN_VALUE_HEADLESS="`echo "${DOCKER_COMMAND_RETURN_VALUE}" | tail --lines=+2`"
	local LINE=''
	local -a LINES_ARRAY=()
	local ARRAY_LENGTH=0
	local ITERATOR=0

	echo -e "${COMMAND_COLOR}${DOCKER_COMMAND}${EOC}"
	echo "${DOCKER_COMMAND_RETURN_VALUE}"
	echo ''
	if [ ! \( "x${DOCKER_COMMAND_RETURN_VALUE_HEADLESS}" = 'x' \) ] ; then
		# Following commented block of code is from a first draft,
		# and was not kept due to security issues it can engender
		#for ELEMENT in ${DOCKER_IMAGES} ; do
		#	aux_remove_docker_images "${ELEMENT}"
		#done
		while IFS= read -r LINE
		do
			LINES_ARRAY[${ARRAY_LENGTH}]="${LINE}"
			ARRAY_LENGTH=$((ARRAY_LENGTH + 1))
		done <<< "${DOCKER_COMMAND_RETURN_VALUE_HEADLESS}"
		#echo "DOCKER_IMAGE(S)_ARRAY: ${LINES_ARRAY[@]}"
		while [ ${ITERATOR} -lt ${ARRAY_LENGTH} ] ; do
			aux_remove_docker_images "${LINES_ARRAY[${ITERATOR}]}"
			ITERATOR=$((ITERATOR + 1))
		done
	fi
}

aux_remove_docker_volumes () {
	local READ_ANSWER=''
	local TARGET_ID=''

	if [ ${#} -eq 1 ] ; then
		echo -e "Would you like to ${COLOR_BRIGHT}remove${EOC} the following ${COLOR_BRIGHT}volume${EOC}:"
		read -n 2 -p "[${1}]? [y/n] " READ_ANSWER
		if [ "x${READ_ANSWER}" = 'xy' ] ; then
			TARGET_ID="`echo "${1}" | awk '{ print $2 }'`"
			docker volume rm "${TARGET_ID}"
		fi
	fi
}

remove_docker_volumes () {
	local DOCKER_COMMAND='docker volume ls'
	local DOCKER_COMMAND_RETURN_VALUE="`${DOCKER_COMMAND}`"
	local DOCKER_COMMAND_RETURN_VALUE_HEADLESS="`echo "${DOCKER_COMMAND_RETURN_VALUE}" | tail --lines=+2`"
	local LINE=''
	local -a LINES_ARRAY=()
	local ARRAY_LENGTH=0
	local ITERATOR=0

	echo -e "${COMMAND_COLOR}${DOCKER_COMMAND}${EOC}"
	echo "${DOCKER_COMMAND_RETURN_VALUE}"
	echo ''
	echo '(Too see docker s volumes along with their respective disk usage, open a new terminal and run:'
	echo -e "\`${COLOR_BRIGHT}sudo ls --size --human-readable --format=single-column /var/lib/docker/volumes/${EOC}\`)"
	echo ''
	if [ ! \( "x${DOCKER_COMMAND_RETURN_VALUE_HEADLESS}" = 'x' \) ] ; then
		while IFS= read -r LINE
		do
			LINES_ARRAY[${ARRAY_LENGTH}]="${LINE}"
			ARRAY_LENGTH=$((ARRAY_LENGTH + 1))
		done <<< "${DOCKER_COMMAND_RETURN_VALUE_HEADLESS}"
		#echo "DOCKER_VOLUME(S)_ARRAY: ${LINES_ARRAY[@]}"
		while [ ${ITERATOR} -lt ${ARRAY_LENGTH} ] ; do
			aux_remove_docker_volumes "${LINES_ARRAY[${ITERATOR}]}"
			ITERATOR=$((ITERATOR + 1))
		done
	fi
}

main () {
	echo -e "To fast clear your docker environnement from its containers, images and volumes, run this script the following way: \`${COLOR_BRIGHT}yes | ${0}${EOC}\`"
	echo -e "If you deployed a docker constellation through docker-compose, consider executing \`${COLOR_BRIGHT}docker-compose down${EOC}\` before running this script"
	stop_running_containers
	remove_exited_containers
	remove_docker_images
	remove_docker_volumes

	echo ''
	local DOCKER_COMMAND=''
	DOCKER_COMMAND='docker container ls --all'
	echo -e "${COMMAND_COLOR}${DOCKER_COMMAND}${EOC}"
	echo "`${DOCKER_COMMAND}`"
	echo ''
	DOCKER_COMMAND='docker network ls'
	echo -e "${COMMAND_COLOR}${DOCKER_COMMAND}${EOC}"
	echo "`${DOCKER_COMMAND}`"
	echo ''
	#DOCKER_COMMAND='docker node ls'
	#echo -e "${COMMAND_COLOR}${DOCKER_COMMAND}${EOC}"
	#echo "`${DOCKER_COMMAND}`"
	#echo ''
	#DOCKER_COMMAND='docker service ls'
	#echo -e "${COMMAND_COLOR}${DOCKER_COMMAND}${EOC}"
	#echo "`${DOCKER_COMMAND}`"
	#echo ''
	DOCKER_COMMAND=''
}

main
