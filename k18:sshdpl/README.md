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

Exemple d'execució blobal docker-compose.f.yml
```
version: "3"
services:
  kserver:
    image: edtasixm11/k18:kserver
    container_name: kserver.edt.org
    hostname: kserver.edt.org
    ports:
      - "88:88"
      - "464:464"
      - "749:749"
    networks:
      - mynet
  sshd:
    image: edtasixm11/k18:sshdpl
    container_name: sshd.edt.org
    hostname: sshd.edt.org
    ports: 
      - "1022:22"
    networks:
      - mynet        
  ldap:
    image: edtasixm06/ldapserver:18group
    container_name: ldap.edt.org
    hostname: ldap.edt.org
    ports: 
      - "389:389"
    networks:
      - mynet
networks:
  mynet:
```

