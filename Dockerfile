FROM python:3.9.0-slim AS base

WORKDIR /usr/src/app

RUN apt-get update && \
    apt-get install -y \
    build-essential libmariadbclient-dev && \
    pip install --upgrade pip && \
    pip install poetry

COPY pyproject.toml poetry.lock ./
RUN poetry install --no-dev

COPY uwsgibug uwsgibug/

RUN echo "\
    \#!/bin/bash \n\
    \
    poetry run uwsgi --socket 0.0.0.0:8000 --master \
    --module=\${MODULE:-uwsgibug.wsgi:application} \
    --workers=6 \
    --socket-timeout=300 \
    --ignore-sigpipe --ignore-write-errors --disable-write-exception \
    --threads=$cores \
    --max-requests=20 \
    --reload-mercy=200 \
    --reload-on-as=350 --reload-on-rss=320" > uwsgibug/startup.sh

RUN chmod 755 uwsgibug/startup.sh

CMD cd uwsgibug && ./startup.sh
