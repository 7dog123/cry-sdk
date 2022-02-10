FROM ubuntu:14.04

RUN mkdir ndk-crystax-r10-build

COPY ndk-crystax-r10-build.sh ndk-crystax-r10-build

WORKDIR /ndk-crystax-r10-build

RUN apt update && \
    apt-get -y install bison flex libtool mingw-w64 git && \
    apt-get -y install git-core gnupg build-essential zip curl && \ 
    apt-get -y install pbzip2 texinfo python3 python3-lxml && \
    apt-get -y install zlib1g-dev gcc-multilib g++-multilib && \
    apt-get -y install libncurses5 libncurses5-dev x11proto-core-dev && \
    apt-get -y install libgl1-mesa-dev libxml2-utils xsltproc && \
    apt-get -y install unzip fontconfig libx11-dev && \
    apt-get -y install gcc-8-locales python3-genshi python3-lxml-dbg

RUN chmod 755 ndk-crystax-r10-build.sh && ./ndk-crystax-r10-build.sh
