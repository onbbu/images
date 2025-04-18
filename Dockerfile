FROM node:23-slim

RUN apt-get update && apt-get install -y git git-flow sudo gcc musl-dev curl make wget bash-completion openssh-client python3 python3-pip docker.io rsync

ENV SHELL=/bin/bash

RUN echo "source /usr/share/bash-completion/completions/git" >> /root/.bashrc

RUN useradd -ms /bin/bash vscode && \
    usermod -aG sudo vscode

RUN echo "vscode ALL=(ALL) NOPASSWD: ALL" > /etc/sudoers.d/vscode
RUN echo "node ALL=(ALL) NOPASSWD: ALL" > /etc/sudoers.d/node

RUN npm install -g gitlab-ci-local

WORKDIR /usr/src/app
