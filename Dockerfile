FROM alpine:latest

LABEL maintainer "Opsani <support@opsani.com>"

WORKDIR /skopos

RUN set -x && \
    apk update && \
    apk upgrade && \
    apk add --update --no-cache \
        ca-certificates \
        python3 \
        py3-psycopg2 && \
    rm -rf /var/cache/apk/*

COPY probe-postgres /skopos/

ADD probe_common /skopos/probe_common

ENTRYPOINT [ "python3", "probe-postgres" ]
