FROM node:22-bullseye

RUN apt-get update -qq && apt-get install -y -qq \
    openjdk-17-jdk \
    wget \
    unzip \
    && rm -rf /var/lib/apt/lists/*

ENV ANDROID_HOME=/usr/local/android-sdk
ENV ANDROID_SDK_TOOLS=11076708 
ENV JAVA_HOME=/usr/lib/jvm/java-17-openjdk-amd64
ENV PATH=${PATH}:${ANDROID_HOME}/cmdline-tools/latest/bin:${ANDROID_HOME}/platform-tools

RUN mkdir -p ${ANDROID_HOME} 
RUN wget -q https://dl.google.com/android/repository/commandlinetools-linux-${ANDROID_SDK_TOOLS}_latest.zip -O /tmp/android-sdk.zip
RUN unzip -q /tmp/android-sdk.zip -d /tmp/android-sdk
RUN rm /tmp/android-sdk.zip
RUN mkdir -p ${ANDROID_HOME}/cmdline-tools
RUN mv /tmp/android-sdk/cmdline-tools ${ANDROID_HOME}/cmdline-tools/latest
RUN yes | sdkmanager --licenses
RUN sdkmanager "platform-tools" "platforms;android-30" "build-tools;30.0.3"

RUN wget -q https://services.gradle.org/distributions/gradle-8.12.1-bin.zip -O /tmp/gradle.zip && \
    unzip -q /tmp/gradle.zip -d /opt && \
    rm /tmp/gradle.zip && \
    ln -s /opt/gradle-8.12.1/bin/gradle /usr/bin/gradle

RUN npm install -g @capacitor/cli

WORKDIR /workspace