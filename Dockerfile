FROM ubuntu:18.04

RUN mkdir -p ndk-crystax-r10-build

RUN export NDK_VERSION=r10e && export NDK_ROOT=/opt/android-ndk && export NDK_HOST=linux-x86_64 && export NDK_PLATFORM=android-21

COPY ndk-crystax-r10-build.sh ndk-crystax-r10-build

WORKDIR /ndk-crystax-r10-build

RUN echo "Installing required packages (Ubuntu 18.04)" && \
    dpkg --add-architecture i386 && apt-get -qq update && apt-get -qq dist-upgrade && \
    apt-get -y install git-core gnupg flex bison gperf build-essential \
    zip wget zlib1g-dev gcc-multilib g++-multilib \
    x11proto-core-dev libx11-dev ccache libgl1-mesa-dev libxml2-utils xsltproc unzip && \
    apt-get -y install libc6:i386 libncurses5:i386 libstdc++6:i386 libz1:i386 && \
    apt-get -y autoclean

RUN mkdir /tmp/android \
    && wget --continue "https://dl.google.com/android/repository/android-ndk-r10e-linux-x86_64.zip" \
    && unzip /tmp/android/android-ndk-r10e-linux-x86_64.zip -d /tmp \
    && mv /tmp/android-ndk-${NDK_VERSION} ${NDK_ROOT} \
    && cd / \
    && rm -rf /tmp/android \
    && find ${NDK_ROOT}/platforms/* -maxdepth 0 ! -name "$NDK_PLATFORM" -type d -exec rm -r {} +


RUN chmod 755 ndk-crystax-r10-build.sh && ./ndk-crystax-r10-build.sh
