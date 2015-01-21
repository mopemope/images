FROM mopemope/java:8

WORKDIR /root
USER root
ENV HOME /root
ENV LEIN_ROOT /root/.lein

RUN wget https://raw.github.com/technomancy/leiningen/stable/bin/lein && \
    install -t /usr/local/bin lein                               && \
    rm lein



