# Kerberos khost
## @edt ASIX M11-SAD Curs 2018-2019

**edtasixm11/k18:khostpl** host amb PAM amb autenticació AP de  kerberos i IP de ldap.
  El servidor kerberos al que contacta s'ha de dir *kserver.edt.org*. El servidor ldap
  s'anomena ldap.edt.org. Aquest host es configura amb authconfig .
  
per generar autenticació PAM amb kerberos i ldap cal:

 * instal·lar pam_krb5, openldap-client i authconfig
 * configurar /etc/pam.d/system-auth per fer ús del mòdul pam_krb5.so

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
