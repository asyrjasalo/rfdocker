#!/bin/bash

if ! id "${UNAME}" >/dev/null 2>&1; then
  echo "${UNAME}:x:${UID}:${GID}:${UNAME},,,:${UHOME}:${SHELL}" >> /etc/passwd
  echo "${UNAME}::17032:0:99999:7:::" >> /etc/shadow
fi

if [ ! -f "/etc/sudoers.d/${UNAME}" ]; then
  echo "${UNAME} ALL=(ALL) NOPASSWD: ALL" > "/etc/sudoers.d/${UNAME}"
  chmod 0440 "/etc/sudoers.d/${UNAME}"
fi

egrep -i "^${GNAME}" /etc/group;
if [ $? -ne 0 ]; then
  echo "${GNAME}:x:${GID}:${UNAME}" >> /etc/group
fi

if [ -d "${UHOME}" ]; then
  home_owner="$(stat -c '%U' ${UHOME})"
  if [ $(id -u ${UNAME}) -ne $(id -u ${home_owner}) ]; then
    chown "${UID}":"${GID}" -R ${UHOME}
  fi
else
  mkdir -p "${UHOME}"
  chown "${UID}":"${GID}" "${UHOME}"
fi

su-exec "${UNAME}" "$@"
