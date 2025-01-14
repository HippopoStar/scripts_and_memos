#!/bin/sh
# shell script to prepend i3status with more stuff

set -o nounset
set -o errexit

trap on_exit EXIT

on_exit () {
	local EXIT_STATUS=${?}

	set +o nounset
	set +o errexit

	if [ ${EXIT_STATUS} -ne 0 ]
	then
		# https://i3wm.org/docs/i3-nagbar.html
		# notify-send (libnotify-bin)
		i3-nagbar -t warning -m "${0} exit status: ${EXIT_STATUS}"
	fi
}

# $> man bash
#
# RESERVED WORDS
#     [...]
# PARAMETERS
#   [...]
#   Special Parameters
#     [...]
#     $       Expands to the process ID of the shell.  In a () subshell, it expands to the process ID of the current shell, not the subshell.
# COMMAND EXECUTION
#     [...]
# SHELL BUILTIN COMMANDS
#     [...]
#     builtin shell-builtin [arguments]
#             Execute the specified shell builtin, passing it arguments, and return its exit status.
#             This is useful when defining a function whose name is the same as a shell builtin, retaining the functionality of the builtin within the function.
#             The cd builtin is commonly redefined this way.
#             The return status is false if shell-builtin is not a shell builtin command.
#     [...]
#     kill [-s sigspec | -n signum | -sigspec] [pid | jobspec] ...
#     kill -l|-L [sigspec | exit_status]
#             Send the signal named by sigspec or signum to the processes named by pid or jobspec.
#             sigspec is either a case-insensitive signal name such as SIGKILL (with or without the SIG prefix) or a signal number; signum is a signal number.
#             If sigspec is not present, then SIGTERM is assumed.
#             An argument of -l lists the signal names.
#             If any arguments are supplied when -l is given, the names of the signals corresponding to the arguments are listed, and the return status is 0.
#             The exit_status argument to -l is a number specifying either a signal number or the exit status of a process terminated by a signal.
#             The -L option is equivalent to -l.
#             kill returns true if at least one signal was successfully sent, or false if an error occurs or an invalid option is encountered.
PATH=$(/usr/bin/getconf PATH || /bin/kill $$)

# ← (2190)
# ↑ (2191)
# → (2192)
# ↓ (2193)
# ↔ (2194)
# ↕ (2195)
# ↖ (2196)
# ↦ (21A6)
# ↯ (21AF)
# ↹ (21B9)
# ↻ (21BB)
# ⇄ (21C4)
# ⇅ (21C5)
# ⇆ (21C6)
# ⇧ (21E7)
# ⇪ (21EA)
# ⇱ (21F1)
# ⇵ (21F5)
# ⌘ (2316)
# ⌚ (231A)
# ⌥ (2325)
# ⌦ (2326)
# ⌨ (2328)
# ⌫ (232B)
# ⍅ (2345)
# ⍆ (2346)
# ⍏ (234F)
# ⍓ (2353)
# ⍖ (2356)
# ⏎ (23CE)
# ⏏ (23CF)
# ⏰ (23F0)
# ☃ (2603)
# ☠ (2620)
# ♨ (2668)
# ⚙ (2699)
# ⚛ (269B)
# ⚠ (26A0)
# ⚡ (26A1)
# ⛄ (26C4)
# ⛓ (26D3)
# ✈ (2708)
# ✉ (2709)
# ✓ (2713)
# ✔ (2714)
# ✗ (2717)
# ✘ (2718)
# ❄ (2744)
# ❅ (2745)
# ❆ (2746)
# ❌ (274C)
# ❔ (2754)
# ❗ (2757)
# ⤓ (2913)
# ⤡ (2921)
# ⤢ (2922)
# ⬁ (2B01)
# ツ (30C4)
# ＋ (FF0B)
# ： (FF1A)
# ； (FF1B)
# ［ (FF3B)
# ］ (FF3D)
# ｜ (FF5C)
# 𝖢𝗍𝗋𝗅 (1D5A0-1D5D3)
# 𝘊𝘵𝘳𝘭 (1D608-1D63B)
# 🌍 (1F30D)
# 🌎 (1F30E)
# 🌏 (1F30F)
# 🌐 (1F310)
# 🌡 (1F321)
# 🍽 (1F37D)
# 🎙 (1F399)
# 🎤 (1F3A4)
# 🎧 (1F3A7)
# 🎩 (1F3A9)
# 🎮 (1F3AE)
# 👤 (1F464)
# 👥 (1F465)
# 👽 (1F47D)
# 👾 (1F47E)
# 💌 (1F48C)
# 💡 (1F4A1)
# 💻 (1F4BB)
# 💾 (1F4BE)
# 💿 (1F4BF)
# 📁 (1F4C1)
# 📂 (1F4C2)
# 📅 (1F4C5)
# 📈 (1F4C8)
# 📋 (1F4CB)
# 📎 (1F4CE)
# 📖 (1F4D6)
# 📡 (1F4E1)
# 📧 (1F4E7)
# 📨 (1F4E8)
# 📩 (1F4E9)
# 📰 (1F4F0)
# 📶 (1F4F6)
# 📷 (1F4F7)
# 📸 (1F4F8)
# 🔅 (1F505)
# 🔆 (1F506)
# 🔇 (1F507)
# 🔈 (1F508)
# 🔉 (1F509)
# 🔊 (1F50A)
# 🔋 (1F50B)
# 🔌 (1F50C)
# 🔑 (1F511)
# 🔒 (1F512)
# 🔓 (1F513)
# 🔔 (1F514)
# 🔕 (1F515)
# 🔗 (1F517)
# 🔥 (1F525)
# 🔧 (1F527)
# 🕒 (1F552)
# 🕰 (1F570)
# 🕵 (1F575)
# 🕶 (1F576)
# 🕸 (1F578)
# 🖥 (1F5A5)
# 🖨 (1F5A8)
# 🖱 (1F5B1)
# 🗑 (1F5D1)
# 🗺 (1F5FA)
# 😌 (1F60C)
# 😎 (1F60E)
# 😴 (1F634)
# 🚫 (1F6AB)
# 🛩 (1F6E9)
# 🤒 (1F912)
# 🤔 (1F914)
# 🤖 (1F916)
# 🤚 (1F91A)
# 🤦 (1F926)
# 🤠 (1F920)
# 🤨 (1F928)
# 🤯 (1F92F)
# 🥪 (1F96A)
# 🥵 (1F975)
# 🦄 (1F984)
# 🧐 (1F9D0)
# 🧢 (1F9E2)
# 🧰 (1F9F0)

# who --users
# uptime --pretty
# pacmd stat / pacmd list-sources

LC_NUMERIC='en_US.UTF-8'
G_FIELD_SEPARATOR='｜'
G_HOTKEYS_MEMO=''
G_HOTKEYS_MEMO_INDEX=0
G_HOTKEYS_MEMO_PERIOD=2
G_CUSTOM_PREFIX=''
G_UPTIME=''
G_WHO=''
G_EARTH_EMOTICON=''
G_EARTH_EMOTICON_INDEX=0
G_PULSE_AUDIO_DEFAULT_SOURCE=''
G_PULSE_AUDIO_DEFAULT_SOURCE_STATUS=''

update_hotkeys_memo () {
	G_HOTKEYS_MEMO_INDEX=$(( (G_HOTKEYS_MEMO_INDEX + 1) % (6 * G_HOTKEYS_MEMO_PERIOD) ))
	case $(( G_HOTKEYS_MEMO_INDEX / G_HOTKEYS_MEMO_PERIOD )) in
		0)
			G_HOTKEYS_MEMO='［i3 window manager］ exit: ⌘＋⇧＋E ; reload: ⌘＋⇧＋C ; restart: ⌘＋⇧＋R ; lock: 𝖢𝗍𝗋𝗅＋⇧＋⌦'
			;;
		1)
			G_HOTKEYS_MEMO='［i3 window manager］ dmenu: ⌘＋D ; kill focused window: ⌘＋⇧＋Q'
			;;
		2)
			G_HOTKEYS_MEMO='［i3 window manager］ layout (stacking: ⌘＋S ; tabbed: ⌘＋W ; toogle split: ⌘＋E)'
			;;
		3)
			G_HOTKEYS_MEMO='［i3 window manager］ split (horizontal: ⌘＋H ; vertical: ⌘＋V ; resize mode: ⌘＋R)'
			;;
		4)
			G_HOTKEYS_MEMO='［i3 window manager］ terminal emulator: ⌘＋⏎ ; file explorer: ⌘＋⇧＋F ; text editor: ⌘＋T ; web browser: ⌘＋B'
			;;
		5)
			G_HOTKEYS_MEMO='［i3 window manager］ network manager: ⌘＋N ; VPN: ⌘＋⇧＋V'
			;;
		*)
			G_HOTKEYS_MEMO=''
			;;
	esac
}

append_to_custom_prefix () {
	if [ -z "${G_CUSTOM_PREFIX}" ]
	then
		G_CUSTOM_PREFIX="${1}"
	else
		G_CUSTOM_PREFIX="${G_CUSTOM_PREFIX}${G_FIELD_SEPARATOR}${1}"
	fi
}

update_uptime () {
	G_UPTIME="up $( uptime | cut -d' ' -f4-6 | tr -d ',')"
}

update_who () {
	G_WHO="who: $( who -u | cut -d' ' -f1 | xargs echo )"
}

update_earth_emoticon () {
	G_EARTH_EMOTICON_INDEX=$(( (G_EARTH_EMOTICON_INDEX + 1) % 3 ))
	case ${G_EARTH_EMOTICON_INDEX} in
		0)
			G_EARTH_EMOTICON=' 🌍 '
			;;
		1)
			G_EARTH_EMOTICON=' 🌎 '
			;;
		2)
			G_EARTH_EMOTICON=' 🌏 '
			;;
		*)
			G_EARTH_EMOTICON=''
			;;
	esac
}

update_pulse_audio_default_source_status () {
	G_PULSE_AUDIO_DEFAULT_SOURCE="$(
		pacmd stat \
		| awk '/^Default source name: / { print $NF }'
	)"
	G_PULSE_AUDIO_DEFAULT_SOURCE_STATUS="$(
		pacmd list-sources \
		| awk 'BEGIN { my_line=9001 }; /^\tname: <'"${G_PULSE_AUDIO_DEFAULT_SOURCE}"'>/ { my_line=NR }; NR>my_line && /^\tmuted: / { print $NF; my_line=9001 };'
	)"
	G_PULSE_AUDIO_DEFAULT_SOURCE_STATUS="🎙muted: ${G_PULSE_AUDIO_DEFAULT_SOURCE_STATUS}"
}

i3status | (
	read line && echo "$line" && read line && echo "$line" && read line && echo "$line"
	while :
	do
		read line
		update_uptime
		update_who
		update_earth_emoticon
		update_pulse_audio_default_source_status
		G_HOTKEYS_MEMO=''
		update_hotkeys_memo
		G_CUSTOM_PREFIX=''
		append_to_custom_prefix "${G_UPTIME}"
		append_to_custom_prefix "${G_WHO}"
		append_to_custom_prefix "${G_EARTH_EMOTICON}"
		append_to_custom_prefix "${G_PULSE_AUDIO_DEFAULT_SOURCE_STATUS}"
		echo "${G_I3_SHORTCUTS}" >&2
		echo "${G_CUSTOM_PREFIX}" >&2
		echo "${line}" >&2
		echo ',[{"full_text":"'"${G_HOTKEYS_MEMO}"'","align":"left","min_width":500,"separator":false,"separator_block_width":50},{"full_text":"'"${G_CUSTOM_PREFIX}"'","separator":true},'"${line#,\[}" || exit 1
	done
)

