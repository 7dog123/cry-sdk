FROM ubuntu:latest

RUN apt-get update && \
    apt-get -y install git-core gnupg flex bison build-essential zip \
    curl zlib1g-dev gcc-multilib g++-multilib libc6-dev-i386 libncurses5 \
    lib32ncurses5-dev x11proto-core-dev libx11-dev lib32z1-dev libgl1-mesa-dev \
    libxml2-utils xsltproc unzip fontconfig wget python2 python3-pip && \
    apt-get -y autoclean

RUN mkdir -p ndk-crystax-r8-build

WORKDIR /ndk-crystax-r8-build

RUN ln -s /usr/bin/python2 /usr/bin/python
RUN ln -s /usr/bin/python2-config /usr/bin/python-config

RUN curl -o /usr/bin/repo \
    https://commondatastorage.googleapis.com/git-repo-downloads/repo
RUN chmod a+x /usr/bin/repo

RUN wget -O - https://www.crystax.net/download/ndk-crystax-r8-build.sh | /bin/sh

