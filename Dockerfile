FROM ubuntu:focal
MAINTAINER Kyle Gregory <kyle@kylegregory.com>

ENV DEBIAN_FRONTEND noninteractive
ENV LC_ALL C.UTF-8

RUN apt-get -qqqy update
RUN apt-get -qqqy install apt-utils software-properties-common dctrl-tools

RUN add-apt-repository -y ppa:isc/bind
RUN apt-get -qqqy update && apt-get -qqqy dist-upgrade && apt-get -qqqy install bind9 bind9-utils

RUN mkdir -p /etc/bind && chown root:bind /etc/bind/ && chmod 755 /etc/bind
RUN mkdir -p /etc/bind/zones && chown bind:bind /etc/bind/zones && chmod 755 /etc/bind/zones
RUN mkdir -p /var/cache/bind && chown bind:bind /var/cache/bind && chmod 755 /var/cache/bind
RUN mkdir -p /var/lib/bind && chown bind:bind /var/lib/bind && chmod 755 /var/lib/bind
RUN mkdir -p /var/log/bind && chown bind:bind /var/log/bind && chmod 755 /var/log/bind
RUN mkdir -p /run/named && chown bind:bind /run/named && chmod 755 /run/named

EXPOSE 53/udp 53/tcp 953/tcp

CMD ["/usr/sbin/named", "-g", "-c", "/etc/bind/named.conf", "-u", "bind"]
