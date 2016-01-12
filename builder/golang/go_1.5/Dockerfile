FROM golang:1.5.2

RUN go get -u github.com/constabulary/gb/...
RUN go get -u github.com/mattes/migrate
RUN go get -u github.com/GeertJohan/go.rice
RUN go get -u github.com/GeertJohan/go.rice/rice
RUN go get -u github.com/tools/godep
RUN go get -u bitbucket.org/liamstask/goose/cmd/goose
RUN go get -u golang.org/x/tools/cmd/vet
RUN go get -u golang.org/x/tools/cmd/cover

RUN apt-get -y update && apt-get -y install sqlite3 git zip tar curl wget socat redis-tools mercurial openssh-client mercurial mysql-client postgresql-common postgresql-client-9.4
RUN git clone git://github.com/creationix/nvm.git .nvm&&\
    . /go/.nvm/nvm.sh &&\
    NVM_DIR=/go/.nvm nvm install v0.12.7 &&\
    NVM_DIR=/go/.nvm nvm use v0.12.7 &&\
    ls -al /go/.nvm/versions/node/v0.12.7 &&\
    /go/.nvm/versions/node/v0.12.7/bin/npm install -g bower gulp webpack browserify 
RUN GOOS=darwin GOARCH=amd64 go install std
RUN GOOS=windows GOARCH=amd64 go install std
RUN GOOS=linux GOARCH=amd64 go install std
RUN cp /usr/bin/base64 /bin/ & cp /usr/bin/base64 /usr/local/bin/ 

