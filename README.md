# Kerberos
## @edt ASIX M11-SAD Curs 2018-2019

**edtasixm11/k18:kserver** servidor kerberos detach. Crea els usuaris pere
  pau (admin), jordi, anna, marta, marta/admin i julia.
  Assignar-li el nom de host: *kserver.edt.org*

**edtasixm11/k18:khost** host client de kerberos. Simplement amb eines 
  kinit, klist i kdestroy (no pam). El servidor al que contacta s'ha 
  de dir *kserver.edt.org*.

**edtasixm11/k18:sshd** Servidor SSHD *kerberitzat*. Servidor ssh que permet 
  l'accés d'usuaris locals i usuaris locals amb autenticació kerberos. El 
  servidor s'ha de dir sshd.edt.org.


Execució:
```
docker netweork create mynet
docker run --rm --name kserver.edt.org -h kserver.edt.org --net mynet -d edtasixm11/k18:kserver
docker run --rm --name sshd.edt.org    -h sshd.edt.org    --net mynet -d edtasixm11/k18:sshd
docker run --rm --name khost -h khost --net mynet -it edtasixm11/k18:khost
```


### Teoria:

**Autenticaction Provider AP**

Kerberos propoerciona el servei de proveïdor d'autenticació. No emmagatzema informació dels comptes d'usuari com
el uid, git, shell, etc. Simplement emmagatzema i gestiona els passwords dels usuaris, en entrades anomenades 
*principals* en la seva base de dades.

Coneixem els següents AP:

 * */etc/passwd* que conté els password (AP) i també la informació dels comptes d'usuari (IP).
 * *ldap* el servei de directori ldap conté informació dels comptes d'uauri (IP) i també els seus passwords (AP).
 * *kerberos* que únicament actua de AP i no de IP.

**Information Provider IP**

Els serveis que emmagatzemen la informació dels comptes d'usuari s'anomenen Information providers. Aquests
serveis proporcionen el uid, gid, shell, gecos, etc. Els clàssics són /etc/passwd i ldap.




