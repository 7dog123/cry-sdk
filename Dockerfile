FROM ubuntu:18.04

RUN mkdir -p ndk-crystax-r10-build

ARG NDK_VERSION=r19
ARG SDK_PLATFORM=android-21
ARG SDK_BUILD_TOOLS=28.0.3

ENV ANDROID_HOME /opt/android-sdk
ENV ANDROID_SDK_ROOT ${ANDROID_HOME}
ENV ANDROID_NDK_ROOT /opt/android-ndk
ENV ANDROID_NDK_HOST linux-x86_64
ENV ANDROID_NDK_PLATFORM android-21
ENV PATH ${ANDROID_HOME}/tools:${ANDROID_HOME}/tools/bin:${ANDROID_HOME}/platform-tools:${PATH}
ENV export JAVA_HOME usr/lib/jvm/java-8-openjdk-amd64
ENV PATH $JAVA_HOME/bin:$PATH

COPY ndk-crystax-r10-build.sh ndk-crystax-r10-build

WORKDIR /ndk-crystax-r10-build

RUN echo "Installing required packages (Ubuntu 18.04)" && \
    dpkg --add-architecture i386 && apt-get -qq update && apt-get -qq dist-upgrade && \
    apt-get -y install git-core gnupg flex bison gperf build-essential \
    zip curl zlib1g-dev gcc-multilib g++-multilib openjdk-8-jdk locales \
    x11proto-core-dev libx11-dev ccache file libgl1-mesa-dev libxml2-utils xsltproc unzip && \
    apt-get -y install libc6:i386 libncurses5:i386 libstdc++6:i386 libz1:i386 && \
    apt-get -y autoclean

RUN curl -Lo /tmp/sdk-tools.zip 'https://dl.google.com/android/repository/sdk-tools-linux-3859397.zip' \
    && mkdir -p ${ANDROID_HOME} \
    && unzip /tmp/sdk-tools.zip -d ${ANDROID_HOME} \
    && rm -f /tmp/sdk-tools.zip \
    && yes | sdkmanager --licenses && sdkmanager --verbose "platforms;${SDK_PLATFORM}" "build-tools;${SDK_BUILD_TOOLS}" ${SDK_PACKAGES}

# Download & unpack android NDK & remove any platform which is not 
RUN mkdir /tmp/android \
    && curl -Lo /tmp/android/ndk.zip "https://dl.google.com/android/repository/android-ndk-${NDK_VERSION}-linux-x86_64.zip" \
    && unzip /tmp/android/ndk.zip -d /tmp \
    && mv /tmp/android-ndk-${NDK_VERSION} ${ANDROID_NDK_ROOT} \
    && cd / \
    && rm -rf /tmp/android \
    && find ${ANDROID_NDK_ROOT}/platforms/* -maxdepth 0 ! -name "$ANDROID_NDK_PLATFORM" -type d -exec rm -r {} +

# Reconfigure locale
RUN locale-gen en_US.UTF-8 && dpkg-reconfigure local

RUN chmod 755 ndk-crystax-r10-build.sh && ./ndk-crystax-r10-build.sh
