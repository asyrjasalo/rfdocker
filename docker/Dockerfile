FROM python:3.6-alpine
MAINTAINER asyrjasalo <anssi.syrjasalo@gmail.com>

RUN apk add --update --no-cache bash sudo su-exec && \
  rm -rf /var/cache/* /tmp/* /var/log/* ~/.cache

COPY entrypoint /usr/local/sbin/

RUN chown root /usr/local/sbin/entrypoint && \
  chmod 700 /usr/local/sbin/entrypoint

ENV UNAME="robot" \
  GNAME="robot" \
  UHOME="/home/robot" \
  UID="1000" \
  GID="1000" \
  SHELL="/bin/bash"

WORKDIR "${UHOME}"

ARG RF_VERSION

COPY requirements.txt .
RUN pip install --no-cache-dir \
  robotframework==$RF_VERSION \
  -r requirements.txt

ENTRYPOINT ["entrypoint", "robot", "--outputdir", "results"]
