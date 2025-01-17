===== ===== ===== ===== =====  
===== BOURNE SHELL  
===== ===== ===== ===== =====  

## dialog
[Debian Manpages - dialog (#whiptail)](https://manpages.debian.org/bookworm/dialog/dialog.1.en.html#WHIPTAIL)  

## notify-send
[Debian Manpages - notify-send](https://manpages.debian.org/bookworm/libnotify-bin/notify-send.1.en.html)  

## getconf
[Debian Manpages - getconf](https://manpages.debian.org/bookworm/libc-bin/getconf.1.en.html)  
[Debian Manpages - sh (#special\ parameters)](https://manpages.debian.org/bookworm/dash/sh.1.en.html#Special_Parameters)  
```
PATH=$(/usr/bin/getconf PATH || /bin/kill $$)
```

## set (builtin)
[Debian Manpages - sh (#builtins)](https://manpages.debian.org/bookworm/dash/sh.1.en.html#Builtins)  
[Debian Manpages - sh (#argument\_list\_processing)](https://manpages.debian.org/bookworm/dash/sh.1.en.html#Argument_List_Processing)  
```
set -o errexit
set -o nounset
```

## trap (builtin)
[Debian Manpages - sh (#builtins)](https://manpages.debian.org/bookworm/dash/sh.1.en.html#Builtins)  
[GNU - Software - libc - Documentation - Signal Handling - Standard Signals](https://www.gnu.org/software/libc/manual/html_node/Standard-Signals.html)  
[Sourceware - gitweb - glibc - bits/signum-generic.h](https://sourceware.org/git/?p=glibc.git;a=blob;f=bits/signum-generic.h;hb=HEAD)  
```
trap on_exit EXIT

on_exit () {
	local EXIT_STATUS=${?}

	if [ ${EXIT_STATUS} -ne 0 ]
	then
		:
	fi

	exit ${EXIT_STATUS}
}
```

## netcat
[Debian Manpages - x-terminal-emulator](https://manpages.debian.org/bookworm/xterm/x-terminal-emulator.1.en.html)  
[Debian Manpages - netcat](https://manpages.debian.org/bookworm/netcat-traditional/netcat.1.en.html)  
```
x-terminal-emulator -e 'nc -l -p 1234'

(
	while :
	do
		echo 'Hi, my name is Dory!'
		sleep 2
	done
) | nc localhost 1234
```

