FROM debian:12

RUN apt update && \
    apt install -y --no-install-recommends \
        python3 python3-dev python3-pip \
        openssh-client openssh-server \
        gcc git git-flow \
        build-essential \
        libffi-dev unzip \
        libssl-dev \
        libpq-dev \
        ca-certificates curl wget \
        apt-transport-https curl gnupg lsb-release ca-certificates \
        bash-completion nano sudo \
        systemd && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/*

RUN curl -fsSL https://packages.sury.org/php/apt.gpg | gpg --dearmor -o /etc/apt/trusted.gpg.d/sury.gpg

RUN echo "deb https://packages.sury.org/php/ bookworm main" | tee /etc/apt/sources.list.d/php.list

RUN apt update

RUN apt install -y php8.3-cli php8.3-xml php8.3-mysql php8.3-zip composer  \
		php8.3-cli php8.3-common php8.3-mysql php8.3-pgsql \
		php8.3-sqlite3 	php8.3-odbc php8.3-gd php8.3-imagick \
		php8.3-curl php8.3-intl php8.3-xml php8.3-mbstring \
		php8.3-zip php8.3-bcmath php8.3-soap php8.3-readline \
		php8.3-ldap php8.3-redis php8.3-xdebug \
	    libnspr4 libnss3 libatk1.0-0 libatk-bridge2.0-0 libxkbcommon0 \
	    libatspi2.0-0 libxcomposite1 libxdamage1 libxfixes3 libxrandr2 \
	    libgbm1 libcairo2 libpango-1.0-0 libasound2 \
        libx11-xcb1 libxcursor1 libgtk-3-0 libpangocairo-1.0-0 \
		libcairo-gobject2 libgdk-pixbuf-2.0-0 && \
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
RUN sudo chmod +x /usr/local/bin/cloudflared

RUN wget https://github.com/jpillora/chisel/releases/download/v1.10.1/chisel_1.10.1_linux_amd64.deb -O /tmp/chisel.deb && \
	dpkg -i /tmp/chisel.deb && \
    rm /tmp/chisel.deb

RUN wget https://github.com/cli/cli/releases/download/v2.76.2/gh_2.76.2_linux_amd64.deb -O /tmp/gh.deb && \
    dpkg -i /tmp/gh.deb && \
    rm /tmp/gh.deb
    
ENV CODE_SERVER_VERSION=4.102.3

RUN wget https://github.com/coder/code-server/releases/download/v${CODE_SERVER_VERSION}/code-server_${CODE_SERVER_VERSION}_amd64.deb -O /tmp/code-server.deb && \
    dpkg -i /tmp/code-server.deb && \
    rm /tmp/code-server.deb

COPY config.yaml /home/vscode/.config/code-server/config.yaml
RUN chown vscode:vscode /home/vscode/.config/code-server/config.yaml

COPY code-server.service /etc/systemd/system/
COPY chisel.service /etc/systemd/system/

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

RUN curl -fsSL https://bun.sh/install | bash

ENV SHELL=/bin/bash
ENV SERVICE_URL=https://marketplace.visualstudio.com/_apis/public/gallery
ENV ITEM_URL=https://marketplace.visualstudio.com/items

EXPOSE 7000 8080

CMD ["/sbin/init"]