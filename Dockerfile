FROM ubuntu:18.04

RUN mkdir ndk-crystax-r10-build

COPY ndk-crystax-r10-build.sh ndk-crystax-r10-build

WORKDIR /ndk-crystax-r10-build

RUN dpkg --add-architecture i386 && apt update && \
    apt -y install git-core gnupg flex file mingw-w64 pbzip2 wine64 && \
    apt -y install bison build-essential zip curl zlib1g-dev && \
    apt -y install gcc-multilib g++-multilib libc6-dev-i386 libncurses5 && \
    apt -y install lib32ncurses5-dev x11proto-core-dev libx11-dev lib32z1-dev && \
    apt -y install libgl1-mesa-dev libxml2-utils xsltproc unzip fontconfig && \
    apt -y install libc6:i386 libncurses5:i386 libstdc++6:i386

RUN chmod 755 ndk-crystax-r10-build.sh && ./ndk-crystax-r10-build.sh
