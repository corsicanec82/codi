FROM ubuntu:18.04

ARG USER_ID=$USER_ID
ARG GROUP_ID=$GROUP_ID
ARG USER_NAME=$USER_NAME
ARG TIMEZONE

RUN apt-get update 
RUN apt-get install -y curl

RUN ln -snf /usr/share/zoneinfo/$TIMEZONE /etc/localtime
RUN echo $TIMEZONE > /etc/timezone

RUN groupadd --gid $GROUP_ID $USER_NAME
RUN useradd --uid $USER_ID --gid $GROUP_ID --shell /bin/bash --create-home $USER_NAME

RUN curl -sL https://deb.nodesource.com/setup_12.x | bash
RUN apt-get install -y nodejs

RUN apt-get install -y php
RUN curl -sL https://getcomposer.org/installer -o composer-setup.php
RUN php composer-setup.php --install-dir=/usr/bin --filename=composer
RUN rm composer-setup.php

WORKDIR /home/$USER_NAME
