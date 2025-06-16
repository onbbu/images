FROM debian:12

RUN apt-get update && \
    apt-get install -y --no-install-recommends \
        python3 python3-dev python3-pip \
        openssh-client \
        gcc git git-flow \
        build-essential \
        libffi-dev unzip \
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

ENV CODE_SERVER_VERSION=4.100.3

RUN wget https://github.com/coder/code-server/releases/download/v${CODE_SERVER_VERSION}/code-server_${CODE_SERVER_VERSION}_amd64.deb -O /tmp/code-server.deb && \
    dpkg -i /tmp/code-server.deb && \
    rm /tmp/code-server.deb

COPY config.yaml /home/vscode/.config/code-server/config.yaml
RUN chown vscode:vscode /home/vscode/.config/code-server/config.yaml

USER vscode
WORKDIR /home/vscode

ENV NODE_VERSION_22=22.14.0
ENV NVM_DIR=/home/vscode/.nvm

RUN curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.40.3/install.sh | bash
RUN . "$NVM_DIR/nvm.sh" && nvm install $NODE_VERSION_22
RUN . "$NVM_DIR/nvm.sh" && nvm alias default $NODE_VERSION_22 && nvm use $NODE_VERSION_22
RUN echo 'export NVM_DIR="/home/vscode/.nvm"' >> /home/vscode/.bashrc
RUN echo '[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"' >> /home/vscode/.bashrc
RUN echo 'export PATH="$NVM_DIR/versions/node/$(nvm version default)/bin:$PATH"' >> /home/vscode/.bashrc

ENV SHELL=/bin/bash

EXPOSE 7000

CMD ["code-server"]