#! /bin/bash
# @edt ASIX M11-SAD Curs 2018-2019
#
/opt/docker/install.sh && echo "Install Ok"
/usr/sbin/krb5kdc -P /var/run/krb5kdc.pid $KRB5KDC_ARGS && echo "KDC OK"
/usr/sbin/kadmind -P /var/run/kadmind.pid -nofork $KADMIND_ARGS && echo "Kadmin OK"

