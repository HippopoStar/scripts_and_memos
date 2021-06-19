#!/bin/bash

COLOR_CODE_BLACK='\033[30m'
COLOR_CODE_RED='\033[31m'
COLOR_CODE_GREEN='\033[32m'
COLOR_CODE_YELLOW='\033[33m'
COLOR_CODE_BLUE='\033[34m'
COLOR_CODE_MAGENTA='\033[35m'
COLOR_CODE_CYAN='\033[36m'
COLOR_CODE_WHITE='\033[37m'

COLOR_CODE_BRIGHT='\033[01m'
COLOR_CODE_RESET='\033[00m'

COLOR_BLACK="$(echo -e "${COLOR_CODE_BLACK}")"
COLOR_RED="$(echo -e "${COLOR_CODE_RED}")"
COLOR_GREEN="$(echo -e "${COLOR_CODE_GREEN}")"
COLOR_YELLOW="$(echo -e "${COLOR_CODE_YELLOW}")"
COLOR_BLUE="$(echo -e "${COLOR_CODE_BLUE}")"
COLOR_MAGENTA="$(echo -e "${COLOR_CODE_MAGENTA}")"
COLOR_CYAN="$(echo -e "${COLOR_CODE_CYAN}")"
COLOR_WHITE="$(echo -e "${COLOR_CODE_WHITE}")"

COLOR_BRIGHT="$(echo -e "${COLOR_CODE_BRIGHT}")"
EOC="$(echo -e "${COLOR_CODE_RESET}")"

usage () {
	local OUTPUT_FILENAME="`echo "$(echo "${0}" | xargs -0 basename | sed 's/\.sh$/\.output/')"`"

	# Note: care to properly escape \" characters while using here documents
	cat <<EOF
${0} [-r|-red <pattern>] [-g|-green <pattern>] [-y|-yellow <pattern>]
	[-b|-blue <pattern>] [-m|-magenta <pattern>] [-c|-cyan <pattern>]
	[-black <pattern>] [-w|-white <pattern>]

Reads on standard input
To use with a file, run \`$(echo -e "${COLOR_CODE_BRIGHT}")${0} <parameters> < <file>$(echo -e "${COLOR_CODE_RESET}")\`
or (slightly slower) \`$(echo -e "${COLOR_CODE_BRIGHT}")cat <file> | ${0} <parameters>$(echo -e "${COLOR_CODE_RESET}")\`
In its current state, this script performs slowly
Consider running \`$(echo -e "${COLOR_CODE_BRIGHT}")${0} <parameters> &> ${OUTPUT_FILENAME} && less --LINE-NUMBERS --RAW-CONTROL-CHARS ${OUTPUT_FILENAME}$(echo -e "${COLOR_CODE_RESET}")\`
Known issue(s):
An artefact will appear on each line matching a pattern and containing a trailing '\' character, and color will not be correctly reset afterwise (solved)
To tackle this, there are, according to your needs, at least 2 ways, both involving editing this script:
- remove the '-r' option passed to the 'read' builtin command (may impact formatting)
- add a space before '\${EOC}' sequence whilst outputting each pattern matching line

As an example, in an experimental purpose, you might try running:
\`$(echo -e "${COLOR_CODE_BRIGHT}")${0} -black 'BLACK' -r 'RED' -g 'GREEN' -y 'YELLOW' -b 'BLUE' -m 'MAGENTA' -c 'CYAN' -w 'WHITE' < ${0}$(echo -e "${COLOR_CODE_RESET}")\`
EOF
}

aux_colorize_patterns () {
	local LINE="${1}"
	local COLOR="${2}"
	local PATTERN="${3}"

	if [ ${#} -eq 3 ]
	then
		echo "${LINE}" \
			| awk '{ gsub(/'"${PATTERN}"'/,"'"${EOC}${COLOR_BRIGHT}${COLOR}"'&'"${EOC}${COLOR}"'"); print "'"${COLOR}"'" $0 "'"${EOC}"'" }'
	fi
}

colorize_patterns () {
	local LINE=''

	while IFS= read -r LINE
	do
		if ( ! [ "x${PATTERN_BLACK}" = 'x' ] && [[ "${LINE}" =~ ${PATTERN_BLACK} ]] )
		then
			aux_colorize_patterns "${LINE}" "${COLOR_BLACK}" "${PATTERN_BLACK}"

		elif ( ! [ "x${PATTERN_RED}" = 'x' ] && [[ "${LINE}" =~ ${PATTERN_RED} ]] )
		then
			aux_colorize_patterns "${LINE}" "${COLOR_RED}" "${PATTERN_RED}"

		elif ( ! [ "x${PATTERN_GREEN}" = 'x' ] && [[ "${LINE}" =~ ${PATTERN_GREEN} ]] )
		then
			aux_colorize_patterns "${LINE}" "${COLOR_GREEN}" "${PATTERN_GREEN}"

		elif ( ! [ "x${PATTERN_YELLOW}" = 'x' ] && [[ "${LINE}" =~ ${PATTERN_YELLOW} ]] )
		then
			aux_colorize_patterns "${LINE}" "${COLOR_YELLOW}" "${PATTERN_YELLOW}"

		elif ( ! [ "x${PATTERN_BLUE}" = 'x' ] && [[ "${LINE}" =~ ${PATTERN_BLUE} ]] )
		then
			aux_colorize_patterns "${LINE}" "${COLOR_BLUE}" "${PATTERN_BLUE}"

		elif ( ! [ "x${PATTERN_MAGENTA}" = 'x' ] && [[ "${LINE}" =~ ${PATTERN_MAGENTA} ]] )
		then
			aux_colorize_patterns "${LINE}" "${COLOR_MAGENTA}" "${PATTERN_MAGENTA}"

		elif ( ! [ "x${PATTERN_CYAN}" = 'x' ] && [[ "${LINE}" =~ ${PATTERN_CYAN} ]] )
		then
			aux_colorize_patterns "${LINE}" "${COLOR_CYAN}" "${PATTERN_CYAN}"

		elif ( ! [ "x${PATTERN_WHITE}" = 'x' ] && [[ "${LINE}" =~ ${PATTERN_WHITE} ]] )
		then
			aux_colorize_patterns "${LINE}" "${COLOR_WHITE}" "${PATTERN_WHITE}"

		else
			echo "${LINE}"
		fi
	done
}

main () {
	local PATTERN_BLACK=''
	local PATTERN_RED=''
	local PATTERN_GREEN=''
	local PATTERN_YELLOW=''
	local PATTERN_BLUE=''
	local PATTERN_MAGENTA=''
	local PATTERN_CYAN=''
	local PATTERN_WHITE=''

	if [ ${#} -eq 0 ]
	then
		echo 'Missing argument(s)'
		usage
		exit 0
	else
		while [ ${#} -gt 0 ]
		do
			if [ ${#} -ge 2 ]
			then
				case "${1}" in
					'-black' )
						PATTERN_BLACK="${2}"
						;;
					'-r' | '-red' )
						PATTERN_RED="${2}"
						;;
					'-g' | '-green' )
						PATTERN_GREEN="${2}"
						;;
					'-y' | '-yellow' )
						PATTERN_YELLOW="${2}"
						;;
					'-b' | '-blue' )
						PATTERN_BLUE="${2}"
						;;
					'-m' | '-magenta' )
						PATTERN_MAGENTA="${2}"
						;;
					'-c' | '-cyan' )
						PATTERN_CYAN="${2}"
						;;
					'-w' | '-white' )
						PATTERN_WHITE="${2}"
						;;
					* )
						echo "Unrecognized argument: \"${1}\""
						usage
						exit 0
						;;
				esac
			else
				echo "Missing corresponding pattern for option: \"${1}\""
				usage
				exit 0
			fi
			shift 2
		done
	fi
	colorize_patterns
}

main "${@}"

