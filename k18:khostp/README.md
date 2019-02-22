# Kerberos khost
## @edt ASIX M11-SAD Curs 2018-2019

**edtasixm11/k18:khostp** host amb PAM de  kerberos. El servidor al que contacta s'ha
  de dir *kserver.edt.org*. Aquest host configura el *system-auth* de pam per usar el
  mòdul *pam_krb5.so*.
  
per generar autenticació PAM kerberos simplement cal:

 * instal·lar pam_krb5
 * configurar /etc/pam.d/system-auth per fer ús del mòdul pam_krb5.so

Execució:
```
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
