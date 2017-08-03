# minimial apline linux with python 3.5:  ~64 MB
FROM jfloff/alpine-python:latest-slim
MAINTAINER Stephen Quintero <stephen@opsani.com>

WORKDIR /skopos

# Install curl, psycopg2 (postgres adapter)
USER root
RUN apk add --update curl py3-psycopg2

COPY probe-postgres /skopos/
ADD probe_common /skopos/probe_common

ENTRYPOINT [ "python3", "probe-postgres" ]
