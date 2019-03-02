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
    image: edtasixm11/k18:sshd
    container_name: sshd.edt.org
    hostname: sshd.edt.org
    ports: 
      - "1022:22"
    networks:
      - mynet        
  ldap:
    image: edtasixm06/ldapserver:18group
    container_name: ldapserver.edt.org
    hostname: ldap.edt.org
    ports: 
      - "389:389"
    networks:
      - mynet
networks:
  mynet:
