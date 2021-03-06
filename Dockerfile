# Base on latest CentOS image
FROM centos:latest

MAINTAINER “Jon Ervine” <jon.ervine@gmail.com>
ENV container docker

# Install updates and some dev tools
RUN yum install -y http://mirror.pnl.gov/epel/7/x86_64/e/epel-release-7-5.noarch.rpm
RUN yum update -y
RUN yum install -y sniproxy supervisor; yum clean all

ADD supervisord.conf /etc/supervisord.conf
ADD sniproxy.ini /etc/supervisord.d/sniproxy.ini
ADD sniproxy.conf /etc/sniproxy.conf
ADD start.sh /usr/sbin/start.sh
RUN chmod 755 /usr/sbin/start.sh

VOLUME /config

EXPOSE 80 443

ENTRYPOINT ["/usr/sbin/start.sh"]
