#!/bin/bash

EOC='\033[00m'
COLOR_BLACK='\033[30m'
COLOR_RED='\033[31m'
COLOR_GREEN='\033[32m'
COLOR_YELLOW='\033[33m'
COLOR_BLUE='\033[34m'
COLOR_MAGENTA='\033[35m'
COLOR_CYAN='\033[36m'
COLOR_WHITE='\033[37m'

main () {
	echo 'To learn more, see [Site du zero - archive offline - Des couleurs dans la console (Linux)](http://sdz.tdct.org/sdz/des-couleurs-dans-la-console-linux.html)'
	echo -e "0. ${COLOR_BLACK}Black${EOC}: \\${COLOR_BLACK}"
	echo -e "1. ${COLOR_RED}Red${EOC}: \\${COLOR_RED}"
	echo -e "2. ${COLOR_GREEN}Green${EOC}: \\${COLOR_GREEN}"
	echo -e "3. ${COLOR_YELLOW}Yellow${EOC}: \\${COLOR_YELLOW}"
	echo -e "4. ${COLOR_BLUE}Blue${EOC}: \\${COLOR_BLUE}"
	echo -e "5. ${COLOR_MAGENTA}Magenta${EOC}: \\${COLOR_MAGENTA}"
	echo -e "6. ${COLOR_CYAN}Cyan${EOC}: \\${COLOR_CYAN}"
	echo -e "7. ${COLOR_WHITE}White${EOC}: \\${COLOR_WHITE}"
}

main
