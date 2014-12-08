FROM bradrydzewski/ubuntu
MAINTAINER Brad Rydzewski <brad@drone.io>

ADD rootfs/etc /etc/
ADD rootfs/root /root/
ADD rootfs/home/ubuntu /home/ubuntu/
RUN whoami && chown -R ubuntu:ubuntu /home/ubuntu && chmod 0440 /etc/sudoers


WORKDIR /home/ubuntu
USER ubuntu
ENV HOME /home/ubuntu
ENV LANG en_US.UTF-8
ENV LANGUAGE en_US:en
ENV LOGNAME ubuntu
ENV TERM xterm

ADD scripts /var/cache/drone/scripts
RUN cd /var/cache/drone/scripts && sudo chmod +x *.sh
WORKDIR /var/cache/drone/scripts
RUN sudo apt-get -qq update && \
    sudo apt-get -y install git git-core subversion mercurial bzr fossil xvfb socat

RUN ./gcc.sh && ./build-essential.sh && ./scons.sh
RUN ./libcurl.sh && \
    ./libffi.sh && \
    ./libgdbm.sh && \
    ./libmagick.sh && \
    ./libmemcache.sh && \
    ./libmysql.sh &&\
    ./libncurses.sh &&\
    ./libossp-uuid.sh &&\
    ./libpq.sh &&\
    ./libqt4.sh &&\
    ./libreadline.sh &&\
    ./libsqlite.sh  &&\
    ./libssl.sh &&\
    ./libxml.sh &&\
    ./libyaml.sh &&\
    ./libzmq.sh &&\
    ./zlib.sh

RUN ./mysql-cli.sh &&\
    ./postgres-client.sh

RUN ./chromium.sh &&\
    ./firefox.sh &&\
    ./chrome.sh &&\
    ./phantomjs.sh 

# install base languages
RUN ./openjdk.sh &&\
    ./python.sh &&\
    ./nodejs.sh &&\
    ./ruby.sh &&\
    ./golang.sh


RUN sudo rm -rf /var/cache/drone/scripts
