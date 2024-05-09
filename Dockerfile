FROM ubuntu:22.04
MAINTAINER Jeff Tseng <jeff810123@gmail.com>
RUN apt-get update
RUN apt-get install git -y
RUN apt-get install autoconf -y
RUN apt-get install automake -y
RUN apt-get install libtool -y
RUN apt-get install m4 -y
RUN apt-get install pkg-config -y
RUN apt-get install libpcre2-dev -y
RUN apt-get install zlib1g-dev -y
RUN apt-get install libssl-dev -y
RUN apt-get install build-essential -y
RUN git clone https://github.com/lighttpd/lighttpd1.4.git
RUN cd lighttpd1.4
RUN git pull
RUN ./autogen.sh
RUN ./configure -C --prefix=/usr/local --with-openssl
RUN make -j 32
RUN make install
RUN mkdir /etc/lighttpd
RUN mkdir /etc/lighttpd/ssl
RUN mkdir /var/www
RUN mkdir /var/www/public
COPY conf/lighttpd.conf /etc/lighttpd/lighttpd.conf
COPY ssl/server.pem /etc/lighttpd/ssl/server.pem
CMD ["/usr/sbin/lighttpd", "-D", "-f", "/etc/lighttpd/lighttpd.conf"]