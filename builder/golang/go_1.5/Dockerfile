FROM golang:1.5
RUN go get -u github.com/constabulary/gb/...
RUN go get -u github.com/mattes/migrate
RUN apt-get update &&\
    apt-get -y install git zip tar curl wget socat mercurial openssh-client mercurial
RUN git clone git://github.com/creationix/nvm.git .nvm&&\
    . /go/.nvm/nvm.sh &&\
    NVM_DIR=/go/.nvm nvm install v0.12.6 &&\
    NVM_DIR=/go/.nvm nvm use v0.12.6 &&\
    ls -al /go/.nvm/versions/node/v0.12.6 &&\
    /go/.nvm/versions/node/v0.12.6/bin/npm install -g bower gulp webpack browserify 

