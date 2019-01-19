FROM centos

RUN yum install -y epel-release && \
    rpm -Uvh https://centos7.iuscommunity.org/ius-release.rpm && \
    yum install -y nginx haproxy18u && \
    yum clean all

COPY nginx-entrypoint.sh /
COPY haproxy.cfg /etc/haproxy
COPY index.tmpl /usr/share/nginx/html


EXPOSE 80 
EXPOSE 8000

CMD ["/nginx-entrypoint.sh"]
