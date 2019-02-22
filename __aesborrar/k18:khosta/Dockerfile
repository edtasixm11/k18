FROM fedora:27
RUN mkdir /opt/docker
RUN dnf -y install krb5-workstation
COPY * /opt/docker/
RUN cp /opt/docker/krb5.conf /etc/krb5.conf
WORKDIR /opt/docker
CMD ["/bin/bash"]

