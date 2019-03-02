# Kerberos khost
## @edt ASIX M11-SAD Curs 2018-2019

**edtasixm11/k18:sshdpls** Servidor SSH  amb PAM (kerberos/ldap) i homes *SAMBA*.
  S'ha generat partint del servidor ssh  edtasixm11/k18:sshdpl i dse li ha afegit 
  la part de muntar els homes samba.



#### Execució:
```
docker run --rm --name ldap.edt.org    -h ldap.edt.org    --net mynet -d edtasixm06/ldapserver:18group
docker run --rm --name kserver.edt.org -h kserver.edt.org --net mynet -d edtasixm11/k18:kserver
docker run --rm --name sshd.edt.org    -h sshd.edt.org    --net mynet --privileged -d edtasixm11/k18:sshdpls
#docker run --rm --name samba.edt.org   -h samba.edt.org   --net mynet --privileged -d edtasixm06/samba:18detach
docker run --rm --name samba.edt.org   -h samba.edt.org   --net mynet --privileged -d edtasixm11/k18:samba
docker run --rm --name khost.edt.org   -h khost.edt.org   --net mynet --privileged -it edtasixm11/k18:khostpl
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

