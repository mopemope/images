FROM mopemope/drone
WORKDIR /home/ubuntu
USER ubuntu
ADD golang.sh /etc/drone.d/

RUN sudo apt-get update &&\
    sudo apt-get -y install zip tar curl wget socat mercurial openssh-client mercurial gcc-mingw-w64 gcc-mingw-w64-i686 gcc-mingw-w64-x86-64
RUN git clone git://github.com/creationix/nvm.git .nvm&&\
    . /home/ubuntu/.nvm/nvm.sh &&\
    NVM_DIR=/home/ubuntu/.nvm nvm install v0.12.4 &&\
    NVM_DIR=/home/ubuntu/.nvm nvm use v0.12.4 &&\
    ls -al /home/ubuntu/.nvm/versions/node/v0.12.4 &&\
    sudo /home/ubuntu/.nvm/versions/node/v0.12.4/bin/npm install -g bower gulp webpack browserify 

#RUN hg clone -u go1.4 https://code.google.com/p/go 
RUN git clone https://go.googlesource.com/go && \
    cd go && \
    git checkout go1.4.2
    
ENV GOROOT /home/ubuntu/go
ENV GOPATH /var/cache/drone
ENV PATH $PATH:$GOROOT/bin:$GOPATH/bin:
WORKDIR /home/ubuntu/go/src

RUN sudo chmod 777 -R /var/cache/drone

RUN ./make.bash
RUN go get github.com/tools/godep
RUN go get github.com/GeertJohan/go.rice
RUN go get github.com/GeertJohan/go.rice/rice
RUN go get bitbucket.org/liamstask/goose/cmd/goose
RUN go get golang.org/x/tools/cmd/vet
RUN go get golang.org/x/tools/cmd/cover
RUN go get -u github.com/mattes/migrate

RUN GOOS=linux GOARCH=386 ./make.bash --no-clean
RUN GOOS=darwin GOARCH=amd64 ./make.bash --no-clean
RUN GOOS=windows GOARCH=386 ./make.bash --no-clean
RUN GOOS=windows GOARCH=amd64 ./make.bash --no-clean
RUN CGO_ENABLED=1 GOOS=windows GOARCH=386 CC_FOR_TARGET="i686-w64-mingw32-gcc -fno-stack-protector -D_FORTIFY_SOURCE=0 -lssp" ./make.bash --no-clean
RUN CGO_ENABLED=1 GOOS=windows GOARCH=amd64 CC_FOR_TARGET="x86_64-w64-mingw32-gcc -fno-stack-protector -D_FORTIFY_SOURCE=0 -lssp" ./make.bash --no-clean
RUN ./make.bash --no-clean
RUN go get -u github.com/tools/godep
RUN go get -u github.com/GeertJohan/go.rice
RUN go get -u github.com/GeertJohan/go.rice/rice
RUN go get -u bitbucket.org/liamstask/goose/cmd/goose
RUN go get -u golang.org/x/tools/cmd/vet
RUN go get -u golang.org/x/tools/cmd/cover
RUN go get -u github.com/mattes/migrate
ADD gb /var/cache/drone/bin/
ADD gb-vendor /var/cache/drone/bin/

WORKDIR /home/ubuntu

