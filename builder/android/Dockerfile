FROM ubuntu:14.04

ENV DEBIAN_FRONTEND noninteractive
RUN echo "debconf shared/accepted-oracle-license-v1-1 select true" | debconf-set-selections
RUN echo "debconf shared/accepted-oracle-license-v1-1 seen true" | debconf-set-selections

RUN apt-get update && apt-get -y upgrade
RUN apt-get -y install software-properties-common python-software-properties bzip2 unzip openssh-client git lib32stdc++6 lib32z1 build-essential subversion wget curl ant

RUN add-apt-repository ppa:webupd8team/java 

RUN apt-get update

RUN apt-get -y install oracle-java7-installer oracle-java8-installer

# Install android sdk
RUN wget http://dl.google.com/android/android-sdk_r24.1.2-linux.tgz
RUN tar -xvzf android-sdk_r24.1.2-linux.tgz
RUN mv android-sdk-linux /usr/local/android-sdk
RUN rm android-sdk_r24.1.2-linux.tgz

# Install Android NDK
RUN wget https://dl.google.com/android/ndk/android-ndk-r10d-linux-x86_64.bin
RUN chmod +x ./android-ndk-r10d-linux-x86_64.bin && ./android-ndk-r10d-linux-x86_64.bin
RUN mv android-ndk-r10d /usr/local/android-ndk
RUN rm android-ndk-r10d-linux-x86_64.bin

# Install Gradle
RUN wget https://services.gradle.org/distributions/gradle-2.3-all.zip
RUN unzip gradle-2.3-all.zip
RUN mv gradle-2.3 /usr/local/gradle
RUN rm gradle-2.3-all.zip

RUN wget http://ftp.meisei-u.ac.jp/mirror/apache/dist/maven/maven-3/3.3.1/binaries/apache-maven-3.3.1-bin.zip
RUN unzip apache-maven-3.3.1-bin.zip
RUN mv apache-maven-3.3.1 /usr/local/maven
RUN rm apache-maven-3.3.1-bin.zip


# Environment variables
ENV ANDROID_HOME /usr/local/android-sdk
ENV ANDROID_SDK_HOME $ANDROID_HOME
ENV ANDROID_NDK_HOME /usr/local/android-ndk
ENV GRADLE_HOME /usr/local/gradle
ENV M2_HOME /usr/local/maven
ENV PATH $PATH:$ANDROID_SDK_HOME/tools
ENV PATH $PATH:$ANDROID_SDK_HOME/platform-tools
ENV PATH $PATH:$ANDROID_NDK_HOME
ENV PATH $PATH:$GRADLE_HOME/bin
ENV PATH $PATH:$M2_HOME/bin

# Install Android tools
RUN echo y | /usr/local/android-sdk/tools/android update sdk -t platform,tool,platform-tool,extra,addon-google_apis-google-8,addon-google_apis-google-10,addon-google_apis-google-15,addon-google_apis-google-16,addon-google_apis-google-17,addon-google_apis-google-18,addon-google_apis-google-19,addon-google_apis-google-21,addon-google_apis-google-22,addon-google_gdk-google-19,build-tools-22.0.1,build-tools-21.1.2 -u -a
RUN echo y | /usr/local/android-sdk/tools/android update sdk -t addon-google_gdk-google-19 -u -a

RUN git clone https://github.com/simpligility/maven-android-sdk-deployer.git
RUN cd maven-android-sdk-deployer && mvn install -X

# Export JAVA_HOME variable
ENV JAVA_HOME /usr/lib/jvm/java-8-oracle
ENV PATH $PATH:$JAVA_HOME/bin
