FROM ubuntu:18.04

RUN mkdir ndk-crystax-r10-build

COPY ndk-crystax-r10-build.sh ndk-crystax-r10-build

WORKDIR /ndk-crystax-r10-build

RUN apt update && \
    apt -y install git-core gnupg flex file mingw-w64 pbzip2 wine-stable && \
    apt -y install bison build-essential zip curl zlib1g-dev && \
    apt -y install gcc-multilib g++-multilib libncurses5 && \
    apt -y install libncurses5-dev x11proto-core-dev libx11-dev && \
    apt -y install libgl1-mesa-dev libxml2-utils xsltproc unzip fontconfig

RUN chmod 755 ndk-crystax-r10-build.sh && ./ndk-crystax-r10-build.sh
