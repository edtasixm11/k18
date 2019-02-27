# Kerberos khost
## @edt ASIX M11-SAD Curs 2018-2019

**edtasixm11/k18:khostpl** host amb PAM amb autenticació AP de  kerberos i IP de ldap.
  El servidor kerberos al que contacta s'ha de dir *kserver.edt.org*. El servidor ldap
  s'anomena ldap.edt.org. Aquest host es configura amb authconfig .
  
per generar autenticació PAM amb kerberos i ldap cal:

Part Global:
  * instal·lar procs passwd.
  * crear els usuaris i assignar password als locals.

Part Ldap:
 * instal·lar openldap-clients nss-pam-ldapd authconfig
 * copiar la configuració client /etc/openldap/ldap.conf.
 * copiar la configuració client /etc/nslcd.
 * copiar la configuració ns /etc/nsswitch.conf.
 * activar el servei nslcd
 * activar el servei nscd

Part Kerberos
 * instal·lar pam_krb5 authconfig
 * copiar /etc/krb5.conf per la configuració client kerberos

Execució:
```
docker run --rm --name ldap.edt.org -h ldap.edt.org --net mynet -d edtasixm06/ldapserver:18group
docker run --rm --name kserver.edt.org -h kserver.edt.org --net mynet -d edtasixm11/k18:kserver
docker run --rm --name khost.edt.org -h khost.edt.org --net mynet -it edtasixm11/k18:khostp
```

```
$ su - local01

[local01@host ~]$ su - user03
Password:  kuser03

[user03@host ~]$ id
uid=1005(user03) gid=100(users) groups=100(users),1001(kusers)
```
