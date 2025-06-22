FROM debian:12

RUN apt-get update && \
    apt-get install -y --no-install-recommends \
        openssh-client \
        gcc git git-flow \
        build-essential \
        libffi-dev unzip \
        libssl-dev \
        libpq-dev \
        ca-certificates curl wget \
        bash-completion nano sudo zip && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/*

RUN adduser --disabled-password --gecos "" vscode
RUN mkdir -p /home/vscode/.config/code-server
RUN chown -R vscode:vscode /home/vscode

RUN usermod -aG sudo vscode

RUN echo "vscode ALL=(ALL) NOPASSWD:ALL" >> /etc/sudoers

RUN echo "source /usr/share/bash-completion/completions/git" >>/home/vscode/.bashrc

RUN wget https://github.com/cloudflare/cloudflared/releases/latest/download/cloudflared-linux-amd64
RUN chmod u+x cloudflared-linux-amd64
RUN mv cloudflared-linux-amd64 /usr/local/bin/cloudflared

ENV CODE_SERVER_VERSION=4.100.3

RUN wget https://github.com/coder/code-server/releases/download/v${CODE_SERVER_VERSION}/code-server_${CODE_SERVER_VERSION}_amd64.deb -O /tmp/code-server.deb && \
    dpkg -i /tmp/code-server.deb && \
    rm /tmp/code-server.deb

COPY config.yaml /home/vscode/.config/code-server/config.yaml
RUN chown vscode:vscode /home/vscode/.config/code-server/config.yaml

USER vscode
WORKDIR /home/vscode
ENV SHELL=/bin/bash

RUN code-server --install-extension vscjava.vscode-java-pack
RUN code-server --install-extension vscjava.vscode-spring-initializr
RUN code-server --install-extension streetsidesoftware.code-spell-checker
RUN code-server --install-extension eamodio.gitlens

ENV MAVEN_VERSION=3.9.10

RUN curl -s "https://get.sdkman.io" | bash

RUN bash -c "source /home/vscode/.sdkman/bin/sdkman-init.sh && sdk install java 21-tem"
RUN bash -c "source /home/vscode/.sdkman/bin/sdkman-init.sh && sdk install maven ${MAVEN_VERSION}"

RUN bash -c "source /home/vscode/.sdkman/bin/sdkman-init.sh && sdk flush archives && sdk flush temp"

RUN bash -c "source /home/vscode/.sdkman/bin/sdkman-init.sh && java -version"
RUN bash -c "source /home/vscode/.sdkman/bin/sdkman-init.sh && mvn -v"

EXPOSE 7000

CMD ["code-server"]
