===== ===== ===== ===== =====  
===== BOURNE SHELL  
===== ===== ===== ===== =====  

```
man sh
```
Table of Contents  
[NAME](https://manpages.debian.org/bookworm/dash/sh.1.en.html#NAME)  
[DESCRIPTION](https://manpages.debian.org/bookworm/dash/sh.1.en.html#DESCRIPTION)  
→ [Overview](https://manpages.debian.org/bookworm/dash/sh.1.en.html#Overview)  
→ [Invocation](https://manpages.debian.org/bookworm/dash/sh.1.en.html#Invocation)  
→ [Argument List Processing](https://manpages.debian.org/bookworm/dash/sh.1.en.html#Argument_List_Processing)  
→ [Lexical Structure](https://manpages.debian.org/bookworm/dash/sh.1.en.html#Lexical_Structure)  
→ [Quoting](https://manpages.debian.org/bookworm/dash/sh.1.en.html#Quoting)  
→ [Backslash](https://manpages.debian.org/bookworm/dash/sh.1.en.html#Backslash)  
→ [Single Quotes](https://manpages.debian.org/bookworm/dash/sh.1.en.html#Single_Quotes)  
→ [Double Quotes](https://manpages.debian.org/bookworm/dash/sh.1.en.html#Double_Quotes)  
→ [Reserved Words](https://manpages.debian.org/bookworm/dash/sh.1.en.html#Reserved_Words)  
→ [Aliases](https://manpages.debian.org/bookworm/dash/sh.1.en.html#Aliases)  
→ [Commands](https://manpages.debian.org/bookworm/dash/sh.1.en.html#Commands)  
→ [Simple Commands](https://manpages.debian.org/bookworm/dash/sh.1.en.html#Simple_Commands)  
→ [Redirections](https://manpages.debian.org/bookworm/dash/sh.1.en.html#Redirections)  
→ [Search and Execution](https://manpages.debian.org/bookworm/dash/sh.1.en.html#Search_and_Execution)  
→ [Path Search](https://manpages.debian.org/bookworm/dash/sh.1.en.html#Path_Search)  
→ [Command Exit Status](https://manpages.debian.org/bookworm/dash/sh.1.en.html#Command_Exit_Status)  
→ [Complex Commands](https://manpages.debian.org/bookworm/dash/sh.1.en.html#Complex_Commands)  
→ [Pipelines](https://manpages.debian.org/bookworm/dash/sh.1.en.html#Pipelines)  
→ [Background Commands – &](https://manpages.debian.org/bookworm/dash/sh.1.en.html#Background_Commands_–_&)  
→ [Lists – Generally Speaking](https://manpages.debian.org/bookworm/dash/sh.1.en.html#Lists_–_Generally_Speaking)  
→ [Short-Circuit List Operators](https://manpages.debian.org/bookworm/dash/sh.1.en.html#Short-Circuit_List_Operators)  
→ [Flow-Control Constructs – if, while, for, case](https://manpages.debian.org/bookworm/dash/sh.1.en.html#Flow-Control_Constructs_–_if,_while,_for,_case)  
→ [Grouping Commands Together](https://manpages.debian.org/bookworm/dash/sh.1.en.html#Grouping_Commands_Together)  
→ [Functions](https://manpages.debian.org/bookworm/dash/sh.1.en.html#Functions)  
→ [Variables and Parameters](https://manpages.debian.org/bookworm/dash/sh.1.en.html#Variables_and_Parameters)  
→ [Positional Parameters](https://manpages.debian.org/bookworm/dash/sh.1.en.html#Positional_Parameters)  
→ [Special Parameters](https://manpages.debian.org/bookworm/dash/sh.1.en.html#Special_Parameters)  
→ [Word Expansions](https://manpages.debian.org/bookworm/dash/sh.1.en.html#Word_Expansions)  
→ [Tilde Expansion (substituting a user's home directory)](https://manpages.debian.org/bookworm/dash/sh.1.en.html#Tilde_Expansion_%28substituting_a_user's_home_directory%29)  
→ [Parameter Expansion](https://manpages.debian.org/bookworm/dash/sh.1.en.html#Parameter_Expansion)  
→ [Command Substitution](https://manpages.debian.org/bookworm/dash/sh.1.en.html#Command_Substitution)  
→ [Arithmetic Expansion](https://manpages.debian.org/bookworm/dash/sh.1.en.html#Arithmetic_Expansion)  
→ [White Space Splitting (Field Splitting)](https://manpages.debian.org/bookworm/dash/sh.1.en.html#White_Space_Splitting_%28Field_Splitting%29)  
→ [Pathname Expansion (File Name Generation)](https://manpages.debian.org/bookworm/dash/sh.1.en.html#Pathname_Expansion_%28File_Name_Generation%29)  
→ [Shell Patterns](https://manpages.debian.org/bookworm/dash/sh.1.en.html#Shell_Patterns)  
→ [Builtins](https://manpages.debian.org/bookworm/dash/sh.1.en.html#Builtins)  
→ [Command Line Editing](https://manpages.debian.org/bookworm/dash/sh.1.en.html#Command_Line_Editing)  
[EXIT STATUS](https://manpages.debian.org/bookworm/dash/sh.1.en.html#EXIT_STATUS)  
[ENVIRONMENT](https://manpages.debian.org/bookworm/dash/sh.1.en.html#ENVIRONMENT)  
[FILES](https://manpages.debian.org/bookworm/dash/sh.1.en.html#FILES)  
[SEE ALSO](https://manpages.debian.org/bookworm/dash/sh.1.en.html#SEE_ALSO)  
[HISTORY](https://manpages.debian.org/bookworm/dash/sh.1.en.html#HISTORY)  
[BUGS](https://manpages.debian.org/bookworm/dash/sh.1.en.html#BUGS)  



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

## Logging
[Site du zero - Des couleurs dans la console (Linux)](http://sdz.tdct.org/sdz/des-couleurs-dans-la-console-linux.html)  
```
C_EOC='\033[00m'
C_BLACK='\033[30m'
C_RED='\033[31m'
C_GREEN='\033[32m'
C_YELLOW='\033[33m'
C_BLUE='\033[34m'
C_MAGENTA='\033[35m'
C_CYAN='\033[36m'
C_WHITE='\033[37m'

log_debug () {
	echo "${C_CYAN}D${C_EOC}: ${@}" >&2
}

log_info () {
	echo "I: ${@}"
}

log_warning () {
	echo "${C_YELLOW}W${C_EOC}: ${@}" >&2
}

log_error () {
	echo "${C_RED}E${C_EOC}: ${@}" >&2
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

