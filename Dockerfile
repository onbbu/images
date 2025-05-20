FROM python:3.12.10-slim-bullseye

RUN apt update && \
    apt install -y git git-flow curl wget bash bash-completion make docker.io nano && \
    apt-get clean && \
    rm -rf /var/lib/apt/lists/*  

RUN useradd -m vscode

RUN echo "source /usr/share/bash-completion/completions/git" >> /home/vscode/.bashrc

USER vscode
WORKDIR /home/vscode

ENV NODE_VERSION_22=22.14.0
ENV NVM_DIR=/home/vscode/.nvm

RUN curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.40.2/install.sh | bash

RUN . "$NVM_DIR/nvm.sh" && nvm install $NODE_VERSION_22 
RUN . "$NVM_DIR/nvm.sh" && nvm alias default $NODE_VERSION_22 && nvm use $NODE_VERSION_22

RUN echo 'export NVM_DIR="/home/vscode/.nvm"' >> /home/vscode/.bashrc
RUN echo '[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"' >> /home/vscode/.bashrc
RUN echo 'export PATH="$NVM_DIR/versions/node/$(nvm version default)/bin:$PATH"' >> /home/vscode/.bashrc

RUN . "$NVM_DIR/nvm.sh" && npm install -g gitlab-ci-local

RUN python3 -m venv /home/vscode/venv

RUN echo 'export VIRTUAL_ENV="/home/vscode/venv"' >> /home/vscode/.bashrc

RUN echo 'export PATH="$VIRTUAL_ENV/bin:$PATH"' >> /home/vscode/.bashrc

RUN /home/vscode/venv/bin/pip install --upgrade pip 

COPY requirements.txt /home/vscode/venv/requirements.txt

RUN /home/vscode/venv/bin/pip install --no-cache-dir -r /home/vscode/venv/requirements.txt

EXPOSE 22
EXPOSE 3000
EXPOSE 3001
EXPOSE 5173
EXPOSE 5174
EXPOSE 8000
EXPOSE 8001
EXPOSE 8080

CMD ["/bin/bash"]
