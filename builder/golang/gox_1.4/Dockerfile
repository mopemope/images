FROM mopemope/drone
WORKDIR /home/ubuntu
USER ubuntu
ADD golang.sh /etc/drone.d/

RUN sudo apt-get -y install socat mercurial openssh-client mercurial gcc-mingw-w64 gcc-mingw-w64-i686 gcc-mingw-w64-x86-64
RUN git clone git://github.com/creationix/nvm.git .nvm&&\
    . /home/ubuntu/.nvm/nvm.sh &&\
    NVM_DIR=/home/ubuntu/.nvm nvm install v0.10.34 &&\
    nvm use v0.10.34 &&\
    sudo npm install -g bower 

RUN hg clone -u release https://code.google.com/p/go 

ENV GOROOT /home/ubuntu/go
ENV GOPATH /home/ubuntu/gopath
ENV PATH $PATH:$GOROOT/bin:$GOPATH/bin:
WORKDIR /home/ubuntu/go/src

RUN ./make.bash
RUN GOOS=linux GOARCH=386 ./make.bash --no-clean
RUN GOOS=darwin GOARCH=386 ./make.bash --no-clean
RUN GOOS=windows GOARCH=386 ./make.bash --no-clean
RUN GOOS=windows GOARCH=amd64 ./make.bash --no-clean
RUN CGO_ENABLED=1 GOOS=windows GOARCH=386 CC_FOR_TARGET="i686-w64-mingw32-gcc -fno-stack-protector -D_FORTIFY_SOURCE=0 -lssp" ./make.bash --no-clean
RUN CGO_ENABLED=1 GOOS=windows GOARCH=amd64 CC_FOR_TARGET="x86_64-w64-mingw32-gcc -fno-stack-protector -D_FORTIFY_SOURCE=0 -lssp" ./make.bash --no-clean

