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
 * *ldap* el servei de directori ldap conté informació dels comptes d'usuari (IP) i també els seus passwords (AP).
 * *kerberos* que únicament actua de AP i no de IP.

**Information Provider IP**

Els serveis que emmagatzemen la informació dels comptes d'usuari s'anomenen Information providers. Aquests
serveis proporcionen el uid, gid, shell, gecos, etc. Els clàssics són /etc/passwd i ldap.


### Model de pràctiques

El model que mantindrem a tot el mòsul ASIX M11-SAD ´es el següent:

 * **ldap** al servidor ldap tenim els usuaris habituals pere, marta, anna, julia, pau, jordi. El seu
  password és el seu propi nom.

 * **/etc/passwd** en els containers hi ha els usuaris locals local01, local02 i local03 que tenen assignat 
  com a passeord el seu mateix nom.

 * **kerberos + IP** els usuaris user01, user02 i user03 són principals de kerberos amb passwords tipus kuser01,
  kuser02 i kuser03. La informació del seu compte d'usuari és local al */etc/passwd* on **no** tenen password
  assignat.

 * **kerberos + ldap** Al servidor kerberos hi ha també principals per als usuaris usuals ldap pere, marta, anna, julia,
  jordi i pau. Els seus passwords són del tipus kpere, kmarta, kanna, kjulia, kjordi i kpau.

Es resum, podem verificar l'accés/autenticació d'usuaris locals usant el prototipus *local01*, podem fer test de la
connectivitat kerberos amb comptes locals amb usuaris tipus *user01*.  I finalment podem verificar l'autenticació
d'usuaris kerberos amb IP ldap amb els clàssics pere (kpere).




