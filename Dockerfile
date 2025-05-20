FROM debian:12

RUN apt-get update && \
    apt-get install -y --no-install-recommends \
        openssh-client \
        gcc git git-flow \
        build-essential \
        libffi-dev \
        libssl-dev \
        libpq-dev \
        ca-certificates curl wget \
        bash-completion nano sudo && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/*

RUN adduser --disabled-password --gecos "" vscode
RUN mkdir -p /home/vscode/.config/code-server
RUN chown -R vscode:vscode /home/vscode

RUN usermod -aG sudo vscode

RUN echo "vscode ALL=(ALL) NOPASSWD:ALL" >> /etc/sudoers

RUN echo "source /usr/share/bash-completion/completions/git" >>/home/vscode/.bashrc

ENV CODE_SERVER_VERSION=4.98.2

RUN wget https://github.com/coder/code-server/releases/download/v${CODE_SERVER_VERSION}/code-server_${CODE_SERVER_VERSION}_amd64.deb -O /tmp/code-server.deb && \
    dpkg -i /tmp/code-server.deb && \
    rm /tmp/code-server.deb

COPY config.yaml /home/vscode/.config/code-server/config.yaml
RUN chown vscode:vscode /home/vscode/.config/code-server/config.yaml

USER vscode
WORKDIR /home/vscode

ENV SHELL=/bin/bash

EXPOSE 3000
EXPOSE 3001
EXPOSE 5173
EXPOSE 5174
EXPOSE 7000
EXPOSE 8000
EXPOSE 8001
EXPOSE 8080

CMD ["code-server"]

