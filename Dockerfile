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
RUN git clone https://github.com/lighttpd/lighttpd1.4.git \
&& cd lighttpd1.4 \
&& git pull \
&& ./autogen.sh \
&& ./configure -C --prefix=/usr/local --with-openssl \
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