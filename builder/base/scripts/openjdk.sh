#!/bin/bash

# install openjdk7 by default
sudo apt-get -y install openjdk-7-jdk

# install commonly used Java build tools
sudo apt-get -y install ant ant-contrib ivy maven

# install utility that allows us to switch JDK versions
sudo apt-get -y install default-jdk

# Download gradle 1.3
wget -O /tmp/gradle-2.2.1-bin.zip https://services.gradle.org/distributions/gradle-2.2.1-bin.zip
cd /tmp
unzip gradle-2.2.1-bin.zip 
rm gradle-2.2.1-bin.zip 
sudo mv gradle-2.2.1 /usr/local
sudo chown -R ubuntu:ubuntu /usr/local/gradle-2.2.1
chmod +x /usr/local/gradle-2.2.1/bin/gradle
