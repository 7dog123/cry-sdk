FROM ubuntu:14.04

RUN mkdir -p ndk-crystax-r10-build

COPY ndk-crystax-r10-build.sh ndk-crystax-r10-build

WORKDIR /ndk-crystax-r10-build

RUN echo "Installing required packages (Ubuntu 14.04)" && \
    dpkg --add-architecture i386 && apt-get -qq update && apt-get -qq dist-upgrade && \
    apt-get -y install git-core gnupg flex bison gperf build-essential \
    zip curl zlib1g-dev gcc-multilib g++-multilib \
    x11proto-core-dev libx11-dev ccache \
    libgl1-mesa-dev libxml2-utils xsltproc unzip wget git python gnupg python-kerberos  && \
    apt-get -y install libc6:i386 libncurses5:i386 libstdc++6:i386 libz1:i386

RUN export OUT_DIR_COMMON_BASE=/ndk-crystax-r10-build/crystax

RUN curl https://storage.googleapis.com/git-repo-downloads/repo > /usr/bin/repo && \
    chmod a+x /usr/bin/repo && mkdir -p ndk_repo cd ndk_repo && repo init -u https://android.googlesource.com/platform/manifest && \
    repo init -u https://android.googlesource.com/platform/manifest -b android-4.0.1_r1 && \
    repo sync

RUN chmod 755 ndk-crystax-r10-build.sh && ./ndk-crystax-r10-build.sh
