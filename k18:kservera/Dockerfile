FROM fedora:27
RUN mkdir /opt/docker
RUN dnf -y install krb5-server krb5-workstation krb5-libs
COPY * /opt/docker/
RUN chmod +x /opt/docker/startup.sh /opt/docker/install.sh
WORKDIR /opt/docker
CMD ["/opt/docker/startup.sh"]

