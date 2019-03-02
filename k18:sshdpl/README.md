# Kerberos khost
## @edt ASIX M11-SAD Curs 2018-2019

**edtasixm11/k18:sshdpl** Servidor SSH  amb PAM amb autenticació AP de  kerberos i IP de ldap.
  El servidor kerberos al que contacta s'ha de dir *kserver.edt.org*. El servidor ldap
  s'anomena ldap.edt.org. Aquest host es configura amb authconfig .
  
 S'ha generat partint del host edtasixm11/k18:khostpl i dse li ha afegit la part del servidor sshd.

 Conté els fitxers per poder activar el mount del home samba, però no s'ha configurat.


#### Execució:
```
docker run --rm --name ldap.edt.org -h ldap.edt.org --net mynet -d edtasixm06/ldapserver:18group
docker run --rm --name kserver.edt.org -h kserver.edt.org --net mynet -d edtasixm11/k18:kserver
docker run --rm --name sshd.edt.org -h sshd.edt.org --net mynet -d edtasixm11/k18:sshdpl
docker run --rm --name khost.edt.org -h khost.edt.org --net mynet -it edtasixm11/k18:khostpl
```

Test:

al verificar que externament es pot accedir al servei ssh en els casos:

  * local01 (usuari local)
  * user01 (usuari compte local passwd kerberos)
  * pere (usuari ldap amb passwd kerberos)
  * user01 amb accés kerberitzat (ja disposant del ticket, accés automàtic)
  * pere  amb accés kerberitzat (ja disposant del ticket, accés automàtic)

```
$ su - local01

[local01@host ~]$ su - user03
Password:  kuser03

[user03@host ~]$ id
uid=1005(user03) gid=100(users) groups=100(users),1001(kusers)
```
