FROM ubuntu:precise

# https://github.com/dotcloud/docker/issues/1024
RUN dpkg-divert --local --rename --add /sbin/initctl && rm -f /sbin/initctl && ln -s /bin/true /sbin/initctl
RUN apt-get -qq update                                                                    
RUN DEBIAN_FRONTEND=noninteractive apt-get install -y mysql-server
RUN sed -i -e"s/^bind-address\s*=\s*127.0.0.1/bind-address = 0.0.0.0/" /etc/mysql/my.cnf
RUN /bin/bash -c "/usr/sbin/mysqld &"                                                     && \
    sleep 10                                                                              && \
    echo "GRANT ALL ON *.* TO root@'%' IDENTIFIED BY '' WITH GRANT OPTION; FLUSH PRIVILEGES" | mysql 

EXPOSE 3306
ENTRYPOINT "/usr/sbin/mysqld"
