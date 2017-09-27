FROM python:3.6-alpine
MAINTAINER asyrjasalo <anssi.syrjasalo@gmail.com>

RUN apk add --update --no-cache bash sudo su-exec && \
  rm -rf /var/cache/* /tmp/* /var/log/* ~/.cache

COPY entrypoint.sh /usr/local/sbin/

RUN chown root /usr/local/sbin/entrypoint.sh && \
  chmod 700 /usr/local/sbin/entrypoint.sh

ENV UNAME="robot" \
    GNAME="robot" \
    UHOME="/home/robot" \
    UID="1000" \
    GID="1000" \
    SHELL="/bin/bash"

WORKDIR "${UHOME}"

COPY requirements.txt .
RUN pip install --no-cache-dir -r requirements.txt

ENTRYPOINT ["entrypoint.sh", "robot", "--outputdir", "results"]
