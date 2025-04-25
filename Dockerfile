FROM php:8.2-cli

ARG USERNAME=vscode
ARG USER_UID=1000
ARG USER_GID=$USER_UID

RUN apt-get update && apt-get install -y \
    unzip \
    curl \
    git bash bash-completion \
    zip \
    libzip-dev \
    libcurl4-openssl-dev \
    libonig-dev \
    libxml2-dev \
    && rm -rf /var/lib/apt/lists/*

ENV SHELL=/bin/bash
ENV PATH="/home/vscode/.composer/vendor/bin:${PATH}"

RUN docker-php-ext-install zip curl mbstring xml pdo pdo_mysql

RUN curl -sS https://getcomposer.org/installer | php -- --install-dir=/usr/local/bin --filename=composer

RUN groupadd --gid $USER_GID $USERNAME \
    && useradd -s /bin/bash --uid $USER_UID --gid $USER_GID -m $USERNAME \
    && apt-get clean

RUN echo "source /usr/share/bash-completion/completions/git" >> /home/vscode/.bashrc

USER $USERNAME

RUN composer global require friendsofphp/php-cs-fixer

WORKDIR /app

SHELL ["/bin/bash", "-c"]

CMD ["php", "-a"]