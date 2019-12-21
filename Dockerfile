FROM ubuntu:18.04

ARG USER_ID=$USER_ID
ARG GROUP_ID=$GROUP_ID
ARG USER_NAME=$USER_NAME

RUN apt-get update
RUN groupadd --gid $GROUP_ID $USER_NAME \
  && useradd --uid $USER_ID --gid $GROUP_ID --shell /bin/bash --create-home $USER_NAME

WORKDIR /home/$USER_NAME