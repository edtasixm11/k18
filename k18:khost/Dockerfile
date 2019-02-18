FROM fedora:27
RUN mkdir /opt/docker
RUN dnf -y install krb5-workstation
COPY * /opt/docker/
WORKDIR /opt/docker
CMD ["/bin/bash"]

