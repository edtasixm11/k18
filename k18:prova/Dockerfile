FROM fedora:27
LABEL author="@edt ASIX M11-SAD"
LABEL description="host PAM kerberos + ldap 2018-2019"
RUN dnf -y install krb5-workstation passwd authconfig pam_krb5  procps nmap openldap-clients nss-pam-ldapd 
RUN mkdir /opt/docker
COPY * /opt/docker/
RUN chmod +x /opt/docker/startup.sh /opt/docker/install.sh
WORKDIR /opt/docker
CMD [ "/opt/docker/startup.sh" ]

