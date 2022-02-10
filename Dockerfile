FROM ubuntu:14.04

RUN mkdir ndk-crystax-r10-build

COPY ndk-crystax-r10-build.sh ndk-crystax-r10-build

WORKDIR /ndk-crystax-r10-build

RUN echo "Installing required packages (Ubuntu 14.04)" && \
    dpkg --add-architecture i386 && apt-get -qq update && apt-get -qq dist-upgrade && \
    apt-get -y install git-core gnupg flex bison gperf build-essential \
    zip curl zlib1g-dev gcc-multilib g++-multilib libc6-dev-i386 \
    lib32ncurses5-dev x11proto-core-dev libx11-dev lib32z-dev ccache \
    libgl1-mesa-dev libxml2-utils xsltproc unzip wget && \
    apt-get -y install libc6:i386 libncurses5:i386 libstdc++6:i386 libz1:i386

RUN echo "Configuring USB Access" && \
    wget -S -O - http://source.android.com/source/51-android.rules | sed "s/<username>/$USER/" | tee >/dev/null /etc/udev/rules.d/51-android.rules; udevadm control --reload-rules

RUN export OUT_DIR_COMMON_BASE=/ndk-crystax-r10-build/crystax

RUN mkdir bin && export PATH=bin:$PATH

RUN curl https://storage.googleapis.com/git-repo-downloads/repo > bin/repo && \
    chmod a+x bin/repo && mkdir ndk_repo cd ndk_repo && repo init -u https://android.googlesource.com/platform/manifest && \
    repo init -u https://android.googlesource.com/platform/manifest -b android-4.0.1_r1 && \
    repo sync

RUN chmod 755 ndk-crystax-r10-build.sh && ./ndk-crystax-r10-build.sh
