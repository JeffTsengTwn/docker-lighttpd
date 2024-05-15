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
RUN apt-get install wget -y
RUN apt-get install libbz2-dev -y
RUN wget https://download.lighttpd.net/lighttpd/releases-1.4.x/lighttpd-1.4.76.tar.gz
RUN tar -xvzf lighttpd-1.4.76.tar.gz \
&& cd  lighttpd-1.4.76 \
&& ./autogen.sh \
&& ./configure -C --prefix=/usr/local --with-openssl --without-pcre \
&& make -j 32 \
&& make install \
&& mkdir /etc/lighttpd \
&& mkdir /etc/lighttpd/ssl \
&& mkdir /var/www \
&& mkdir /var/www/public
COPY conf/lighttpd.conf /etc/lighttpd/lighttpd.conf
COPY ssl/server.pem /etc/lighttpd/ssl/server.pem
COPY public/index.html /var/www/public/index.html 
CMD ["/usr/local/sbin/lighttpd", "-D", "-f", "/etc/lighttpd/lighttpd.conf"]