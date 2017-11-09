ARG PYTHON_VERSION
FROM python:"$PYTHON_VERSION"-alpine

RUN apk add --update --no-cache bash sudo su-exec && \
  rm -rf /var/cache/* /tmp/* /var/log/* ~/.cache

COPY entrypoint /usr/local/sbin/

RUN chown root /usr/local/sbin/entrypoint && \
  chmod 700 /usr/local/sbin/entrypoint

ENV UNAME="robot" \
    GNAME="robot" \
    UHOME="/home/robot" \
    HOST_UID="1000" \
    HOST_GID="1000" \
    SHELL="/bin/bash"

ARG RF_VERSION
RUN pip install --no-cache-dir robotframework=="$RF_VERSION"

WORKDIR "$UHOME"

ENTRYPOINT ["entrypoint", "robot", "--outputdir", "results"]
