#!/bin/bash

COLOR_BLACK='\033[30m'
COLOR_RED='\033[31m'
COLOR_GREEN='\033[32m'
COLOR_YELLOW='\033[33m'
COLOR_BLUE='\033[34m'
COLOR_MAGENTA='\033[35m'
COLOR_CYAN='\033[36m'
COLOR_WHITE='\033[37m'

COLOR_BRIGHT='\033[01m'
EOC='\033[00m'

usage () {
	local OUTPUT_FILENAME="`echo "$(echo "${0}" | xargs basename | sed 's/\.sh$/\.output/')"`"

	# Note: care to properly escape \" characters while using here documents
	cat <<EOF
${0} [-r|-red <pattern>] [-g|-green <pattern>] [-y|-yellow <pattern>]
	[-b|-blue <pattern>] [-m|-magenta <pattern>] [-c|-cyan <pattern>]
	[-black <pattern>] [-w|-white <pattern>]

Reads on standard input
To use with a file, run \`$(echo -e "${COLOR_BRIGHT}")${0} <parameters> < <file>$(echo -e "${EOC}")\`
or (slightly slower) \`$(echo -e "${COLOR_BRIGHT}")cat <file> | ${0} <parameters>$(echo -e "${EOC}")\`
In its current state, this script performs slowly
Consider running \`$(echo -e "${COLOR_BRIGHT}")${0} <parameters> &> ${OUTPUT_FILENAME} && less --LINE-NUMBERS --RAW-CONTROL-CHARS ${OUTPUT_FILENAME}$(echo -e "${EOC}")\`
Known issue(s):
An artefact will appear on each line matching a pattern and containing a trailing '\' character, and color will not be correctly reset afterwise
To tackle this, there are, according to your needs, at least 2 ways, both involving editing this script:
- remove the '-r' option passed to the 'read' builtin command (may impact formatting)
- add a space before '\${EOC}' sequence whilst outputting each pattern matching line

As an example, in an experimental purpose, you might try running:
\`$(echo -e "${COLOR_BRIGHT}")${0} -black 'BLACK' -r 'RED' -g 'GREEN' -y 'YELLOW' -b 'BLUE' -m 'MAGENTA' -c 'CYAN' -w 'WHITE' < ${0}$(echo -e "${EOC}")\`
EOF
}

aux_colorize_patterns () {
	local LINE_HIGHLIGHTED=''
	local LINE="${1}"
	local COLOR="${2}"
	local PATTERN="${3}"

	if [ ${#} -eq 3 ]
	then
		LINE_HIGHLIGHTED="$(echo "${LINE}" | sed 's/'"${PATTERN}"'/'"\\${COLOR_BRIGHT}${PATTERN}\\${EOC}\\${COLOR}"'/g')"
		echo -e "${COLOR}${LINE_HIGHLIGHTED}${EOC}"
	fi
}

colorize_patterns () {
	local LINE=''

	while IFS= read -r LINE
	do
		if [ ! \( "x${PATTERN_BLACK}" = 'x' \
			-o "x`echo "${LINE}" | grep -e "${PATTERN_BLACK}"`" = 'x' \) ]
		then
			aux_colorize_patterns "${LINE}" "${COLOR_BLACK}" "${PATTERN_BLACK}"

		elif [ ! \( "x${PATTERN_RED}" = 'x' \
			-o "x`echo "${LINE}" | grep -e "${PATTERN_RED}"`" = 'x' \) ]
		then
			aux_colorize_patterns "${LINE}" "${COLOR_RED}" "${PATTERN_RED}"

		elif [ ! \( "x${PATTERN_GREEN}" = 'x' \
			-o "x`echo "${LINE}" | grep -e "${PATTERN_GREEN}"`" = 'x' \) ]
		then
			aux_colorize_patterns "${LINE}" "${COLOR_GREEN}" "${PATTERN_GREEN}"

		elif [ ! \( "x${PATTERN_YELLOW}" = 'x' \
			-o "x`echo "${LINE}" | grep -e "${PATTERN_YELLOW}"`" = 'x' \) ]
		then
			aux_colorize_patterns "${LINE}" "${COLOR_YELLOW}" "${PATTERN_YELLOW}"

		elif [ ! \( "x${PATTERN_BLUE}" = 'x' \
			-o "x`echo "${LINE}" | grep -e "${PATTERN_BLUE}"`" = 'x' \) ]
		then
			aux_colorize_patterns "${LINE}" "${COLOR_BLUE}" "${PATTERN_BLUE}"

		elif [ ! \( "x${PATTERN_MAGENTA}" = 'x' \
			-o "x`echo "${LINE}" | grep -e "${PATTERN_MAGENTA}"`" = 'x' \) ]
		then
			aux_colorize_patterns "${LINE}" "${COLOR_MAGENTA}" "${PATTERN_MAGENTA}"

		elif [ ! \( "x${PATTERN_CYAN}" = 'x' \
			-o "x`echo "${LINE}" | grep -e "${PATTERN_CYAN}"`" = 'x' \) ]
		then
			aux_colorize_patterns "${LINE}" "${COLOR_CYAN}" "${PATTERN_CYAN}"

		elif [ ! \( "x${PATTERN_WHITE}" = 'x' \
			-o "x`echo "${LINE}" | grep -e "${PATTERN_WHITE}"`" = 'x' \) ]
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

main ${@}

