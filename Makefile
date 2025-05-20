install-java:
	@echo "Actualizando repositorios..."
	sudo apt update
	
	@echo "Instalando OpenJDK 21, Maven, Gradle y Glade..."
	# Instalar OpenJDK 21 (puede que no esté en repos oficiales, agregamos repositorio adoptopenjdk)
	sudo apt install -y wget gnupg software-properties-common
	
	# Agregar repositorio para OpenJDK 21 (Adoptium)
	wget -qO - https://packages.adoptium.net/artifactory/api/gpg/key/public | sudo tee /usr/share/keyrings/adoptium.asc > /dev/null
	echo "deb [signed-by=/usr/share/keyrings/adoptium.asc] https://packages.adoptium.net/artifactory/deb jammy main" | sudo tee /etc/apt/sources.list.d/adoptium.list
	
	sudo apt update
	sudo apt install -y temurin-21-jdk maven gradle glade

	java -version
	mvn -version
	gradle -v
	glade --version || echo "Glade instalado"

clean:
	sudo apt remove -y temurin-21-jdk maven gradle glade
	sudo apt autoremove -y
	sudo apt clean


install-php:
	sudo apt update
	sudo apt install -y \
		php \
		php-cli \
		php-common \
		php-fpm \
		php-mysql \
		php-sqlite3 \
		php-pgsql \
		php-curl \
		php-mbstring \
		php-xml \
		php-zip \
		php-bcmath \
		php-gd \
		php-intl \
		php-readline \
		php-soap \
		php-xdebug \
		php-imagick \
		php-opcache

	@echo "Instalando Composer..."
	php -r "copy('https://getcomposer.org/installer', 'composer-setup.php');"
	php composer-setup.php --install-dir=/usr/local/bin --filename=composer
	php -r "unlink('composer-setup.php');"
	composer --version
install-bun:
  curl -fsSL https://bun.sh/install | bash
