===== ===== ===== ===== =====  
===== BOURNE SHELL  
===== ===== ===== ===== =====  

## dialog
[Debian Manpages - dialog (#whiptail)](https://manpages.debian.org/bookworm/dialog/dialog.1.en.html#WHIPTAIL)  

## notify-send
[Debian Manpages - notify-send](https://manpages.debian.org/bookworm/libnotify-bin/notify-send.1.en.html)  

## getconf
[Debian Manpages - getconf](https://manpages.debian.org/bookworm/libc-bin/getconf.1.en.html)  
[Debian Manpages - sh (#special\_parameters)](https://manpages.debian.org/bookworm/dash/sh.1.en.html#Special_Parameters)  
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

## Argument processing
```
G_OPTION_NAME=

main () {
	while [ ${#} -gt 0 ]
	do
		case "${1}" in
			--option-name=*)
				G_OPTION_NAME="${1#--option-name=}"
				;;
		[...]
			*)
				echo "Unknown option: ${1}" >&2
				exit 1
				;;
		esac
		shift
	done
}

main "${@}"
```

## Data flow
```
tail -f /var/log/syslog
```
```
CURL_TRACE_FILE=<filename>
DATA_STREAM_URL=<url>

curl --trace-ascii "${CURL_TRACE_FILE}" -X GET "${DATA_STREAM_URL}" &
LAST_PID=${!}
tail -f "${CURL_TRACE_FILE}" --pid=${LAST_PID} | grep --line-buffered -e <pattern>
# <=>
curl --trace-ascii - -X GET "${DATA_STREAM_URL}" | tee "${CURL_TRACE_FILE}" | grep --line-buffered -e <pattern>
```

## date
```
date '+%F %T%:z'
date --rfc-3339=seconds
date '+%Y_%m_%d_%H%M%S'
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

## nohup
[Debian Manpages - nohup](https://manpages.debian.org/bookworm/coreutils/nohup.1.en.html)  

## tmux
[Debian Manpages - tmux](https://manpages.debian.org/bookworm/tmux/tmux.1.en.html)  
```
tmux new [-s session-name]
# C-b d (Detach the current client)
tmux ls
tmux attach [-t target-session]

# C-b % (Split the current pane into two, left and right)
# C-b " (Split the current pane into two, top and bottom)

# C-b c (Create a new window)
# C-b w (Choose the current window interactively)
# C-b p (Change to the previous window)
# C-b n (Change to the next window)

# C-b ? (List all key bindings)
```
[Debian Manpages - screen](https://manpages.debian.org/bookworm/screen/screen.1.en.html)  
```
screen [-S sessionname]
# C-a d (detach: Detach screen from this terminal)
screen -ls
screen -r [pid.tty.host]

# C-a S (split: Split the current region horizontally into two new ones)
# C-a | (split -v: Split the current region vertically into two new ones)
# C-a X (remove: Kill the current region)

# C-a c (screen: Create a new window with a shell and switch to that window)
# C-a " (windowlist -b: Present a list of all windows for selection)
# C-a p (prev: Switch to the previous window)
# C-a n (next: Switch to the next window)
# C-a k (kill: Destroy current window)
# C-a \ (quit: Kill all windows and terminate screen)

# C-a ? (help: Show key bindings)
```

