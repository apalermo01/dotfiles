FROM python:3.12.1-slim-bullseye

RUN apt-get update && \
    apt-get -y install --reinstall ca-certificates && \
    apt-get -y install software-properties-common curl git build-essential direnv && \
    rm -rf /var/lib/apt/lists/*

ARG USER=vscode 
ARG UID=1000
ARG GID=1000

RUN groupadd -g ${GID} ${USER} && \
    useradd -m -s /bin/bash -u ${UID} -g ${GID} ${USER} && \
    mkdir -p /home/${USER}/.cache && chown -R ${UID}:${GID} /home/${USER}

WORKDIR /workspace
USER ${USER}
