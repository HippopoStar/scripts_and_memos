#!/bin/bash

usage () {
	echo "<.|source> <script_name>.sh"
}

set_fancy_prompt () {
	PS1='${debian_chroot:+($debian_chroot)}\[\033[01;33m\]\u\[\033[00;37m\]@\[\033[01;36m\]\h\[\033[00m\]:\[\033[00;34m\]\w\[\033[00m\]\$ '
	unset color_prompt force_color_prompt
}

main () {
	usage
	read -n 2 -p 'Did you properly launch this script the way described above? [y/n] ' ANSWER
	if [ "x${ANSWER}" = 'xy' ] ; then
		set_fancy_prompt
		echo 'If you are willing to definitly use that color configuration, take a look to ~/.bashrc, figuring out how to permanently set this configuration should be easy (it is nonetheless advised to backup the file before proceeding to any changes)'
	fi
}

main
