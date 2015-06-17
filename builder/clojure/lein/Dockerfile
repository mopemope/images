FROM mopemope/java:7

RUN git clone git://github.com/creationix/nvm.git .nvm&&\
    . /home/ubuntu/.nvm/nvm.sh &&\
    NVM_DIR=/home/ubuntu/.nvm nvm install v0.10.35 &&\
    nvm use v0.10.35 &&\
    sudo /home/ubuntu/.nvm/v0.10.35/bin/npm install -g bower

WORKDIR /root
USER root
ENV HOME /root
ENV LEIN_ROOT /root/.lein

RUN wget https://raw.github.com/technomancy/leiningen/stable/bin/lein && \
    install -t /usr/local/bin lein                               && \
    rm lein
