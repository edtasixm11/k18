#! /bin/bash
/opt/docker/install.sh && echo "Ok install"
/usr/sbin/krb5kdc
/usr/sbin/kadmind -nofork 
