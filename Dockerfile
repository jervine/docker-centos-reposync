FROM centos:latest
MAINTAINER Jonathan Ervine <jon.ervine@gmail.com>

RUN yum install -y epel-release
RUN yum install -y yum-utils createrepo ansible httpd supervisor sudo
RUN yum update -y &&  yum clean all
RUN rm -rf /var/cache/yum

ADD supervisord.conf /etc/supervisord.conf
ADD httpd.ini /etc/supervisord.d/httpd.conf
ADD start.sh /sbin/start.sh
RUN chmod 755 /sbin/start.sh

VOLUME /config /repos

EXPOSE 80 9020

ENTRYPOINT ["/sbin/start.sh"]
