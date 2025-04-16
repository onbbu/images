FROM node:23-slim

RUN apt-get update && apt-get install -y git git-flow gcc musl-dev curl make wget bash-completion openssh-client python3 python3-pip docker.io rsync

ENV SHELL=/bin/bash

RUN echo "source /usr/share/bash-completion/completions/git" >> /root/.bashrc

RUN npm install -g gitlab-ci-local

WORKDIR /usr/src/app
