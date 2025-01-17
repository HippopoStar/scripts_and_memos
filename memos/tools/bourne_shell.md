===== ===== ===== ===== =====  
===== BOURNE SHELL  
===== ===== ===== ===== =====  

## dialog
[Debian Manpages - Wheezy - dialog - #whiptail](https://manpages.debian.org/wheezy/dialog/dialog.1.en.html#WHIPTAIL)  

## notify-send
[Debian Manpages - Wheezy - notify-send](https://manpages.debian.org/wheezy/libnotify-bin/notify-send.1.en.html)  

## getconf
[Debian Manpages - Wheezy - getconf](https://manpages.debian.org/wheezy/libc-bin/getconf.1.en.html)  
[Debian Manpages - Wheezy - sh - #Special Parameters](https://manpages.debian.org/wheezy/dash/sh.1.en.html#Special_Parameters)  
```
PATH=$(/usr/bin/getconf PATH || /bin/kill $$)
```

## set (builtin)
[Debian Manpages - Wheezy - sh - #Builtins](https://manpages.debian.org/wheezy/dash/sh.1.en.html#Builtins)  
[Debian Manpages - Wheezy - sh - #Argument List Processing](https://manpages.debian.org/wheezy/dash/sh.1.en.html#Argument_List_Processing)  
```
set -o errexit
set -o nounset
```

## trap (builtin)
[Debian Manpages - Wheezy - sh - #Builtins](https://manpages.debian.org/wheezy/dash/sh.1.en.html#Builtins)  
[GNU - Software - libc - Documentation - 25.2 Standard Signals](https://www.gnu.org/software/libc/manual/html_node/Standard-Signals.html)  
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

