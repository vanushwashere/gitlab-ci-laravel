FROM php:7.4-buster
MAINTAINER Vanush Ghamaryan <vanush.kamaryan@gmail.com>
RUN rm /etc/apt/preferences.d/no-debian-php
RUN apt-get update && apt-get install -y \
	    git \
	    libcurl4-gnutls-dev \
	    libicu-dev \
	    libmcrypt-dev \
	    libvpx-dev \
	    libjpeg-dev \
	    libpng-dev \
	    libxpm-dev \
	    zlib1g-dev \
	    libfreetype6-dev \
	    libxml2-dev \
	    libexpat1-dev \
	    libbz2-dev \
	    libgmp3-dev \
	    libldap2-dev \
	    unixodbc-dev \
	    libpq-dev \
	    libsqlite3-dev \
	    libaspell-dev \
	    libsnmp-dev \
	    libpcre3-dev \
	    libtidy-dev \
	    software-properties-common \
	    zip unzip libzip-dev\
	    ntfs-3g\
	    cifs-utils \
	    default-mysql-client \
	    gnupg \
	    iputils-ping \
	    libmagickwand-dev \
	    g++ \
	    zlib1g-dev \
        libonig-dev
RUN docker-php-ext-install pcntl mbstring pdo_mysql curl json intl gd xml zip bz2 opcache soap tidy\
    && pecl install xdebug \
    && docker-php-ext-enable xdebug \
    && pecl install redis \
    && docker-php-ext-enable redis \
    && pecl install mongodb \
    && docker-php-ext-enable mongodb\
    && pecl install mailparse \
    && docker-php-ext-enable mailparse\
    && pecl install imagick \
    && docker-php-ext-enable imagick \
    && pecl install grpc \
    && docker-php-ext-enable grpc \
    && docker-php-ext-install exif \
    && docker-php-ext-enable exif \
    && docker-php-ext-configure pcntl --enable-pcntl
RUN cd ~ \
    && curl -sS https://getcomposer.org/installer | php -- --install-dir=/usr/local/bin --filename=composer
RUN mkdir -p /usr/local/nvm/ && \
      curl --silent -o- https://raw.githubusercontent.com/creationix/nvm/v0.39.1/install.sh | bash
RUN echo 'export NVM_DIR="$HOME/.nvm"'                                       >> "$HOME/.bashrc"
RUN echo '[ -s "$NVM_DIR/nvm.sh" ] && . "$NVM_DIR/nvm.sh"  # This loads nvm' >> "$HOME/.bashrc"
RUN echo '[ -s "$NVM_DIR/bash_completion" ] && . "$NVM_DIR/bash_completion" # This loads nvm bash_completion' >> "$HOME/.bashrc"
RUN bash -c "source $HOME/.nvm/nvm.sh \
    && nvm install 'lts/*' \
    && nvm install 7.10.1 \
    && nvm install node"
ENV NODE_PATH $NVM_DIR/v$NODE_VERSION/lib/node_modules
ENV PATH $NVM_DIR/versions/node/v$NODE_VERSION/bin:$PATH
