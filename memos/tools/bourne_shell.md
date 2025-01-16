===== ===== ===== ===== =====  
===== BOURNE SHELL  
===== ===== ===== ===== =====  

`dialog`: A tool to display dialog boxes from shell scripts  

```
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
```

