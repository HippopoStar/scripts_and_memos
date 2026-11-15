#!/bin/sh

set -eu

PATH="$(/usr/bin/getconf PATH)"
export PATH

TMP_DIR=''

on_exit() {
    local EXIT_STATUS=${?}
    local -
    set +eu
    trap - EXIT INT TERM

    if [ \( -n "${TMP_DIR}" \) -a \( -d "${TMP_DIR}" \) ]; then
        rm -rf "${TMP_DIR:?}"
    fi
    if [ ${EXIT_STATUS} -ne 0 ]; then
        echo 'An error occurred.' >&2
        exit ${EXIT_STATUS}
    fi
}

# Signal descriptions: https://sourceware.org/git/?p=glibc.git;a=blob;f=bits/signum-generic.h;hb=HEAD
trap on_exit EXIT INT TERM

TMP_DIR="$(mktemp -d /tmp/tmp.XXXXXX)"

usage() {
    cat <<_EOF >&2
usage: ${0} <wrapper_name> <command_path> [arguments...]

[SYNOPSIS]
    This script generates a wrapper that enables a non-privileged user to run a provided command as root.
    Write permissions for this script, the generated wrapper, and the underlying executable(s) must be restricted to the root user.
    Granting execute permission to the designated user can be achieved either by:
    - using "chmod o+x" (simpler, though anyone able to reach the wrapper can run it)
    - using "chown root:<dedicated_group>" + "chmod u+s" (safer; note that chown clears the SUID bit)

[DISCLAIMER]
    - <command_path> must be provided as an absolute path.
    - The executable at <command_path> must not allow running arbitrary commands (e.g., this script, /bin/sh or /usr/bin/python3).
    - Ensure only root has write permissions on the involved files (otherwise, it would create a privilege escalation vulnerability).
    - There are several ways to misuse this script; use with caution.

[EXAMPLES]
    ${0} privileged_whoami /usr/bin/whoami
    ${0} delayed_shutdown /usr/bin/systemd-run --on-active=5s --unit=delayed_shutdown shutdown -h now
    ${0} my_script /root/.bin/my_script.sh
_EOF
}

generate_executable() {
    local BINARY_NAME="${1}"
    local TARGET_PATH="${2}"
    local TARGET_ARGV="\"${2}\""

    shift 2
    while [ ${#} -gt 0 ]; do
        TARGET_ARGV="${TARGET_ARGV}, \"${1}\""
        shift
    done

    cat <<_EOF | tee "${TMP_DIR}/${BINARY_NAME}.c"
#include <errno.h>
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <unistd.h>

int main(void)
{
  int ret_val;

  if (0 != (ret_val = (setgid(0) || setuid(0))))
  {
    fprintf(stderr, "error: %s\n", strerror(errno));
  }
  else
  {
    static char *nargv[] = { ${TARGET_ARGV}, NULL };
    static char *nenviron[] = { "PATH=/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin", NULL };
    if (0 != (ret_val = execve("${TARGET_PATH}", nargv, nenviron)))
    {
      fprintf(stderr, "error: %s\n", strerror(errno));
    }
  }
  return (ret_val ? EXIT_FAILURE : 0);
}
_EOF

    gcc -o "${TMP_DIR}/${BINARY_NAME}.out" -Wall -Wextra -Werror "${TMP_DIR}/${BINARY_NAME}.c"
    install -o root -g root -m 4710 "${TMP_DIR}/${BINARY_NAME}.out" "./${BINARY_NAME}.out"
    rm "${TMP_DIR}/${BINARY_NAME}.c" "${TMP_DIR}/${BINARY_NAME}.out"
}

main() {
    if [ ${#} -lt 2 ]; then
        usage
    elif [ "$(id -u):$(id -g)" != '0:0' ]; then
        echo 'This script requires root privileges.' >&2
    else
        generate_executable "${@}"
    fi
}

main "${@}"

