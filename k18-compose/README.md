# Kerberos
## @edt ASIX M11-SAD Curs 2018-2019

**docker-compose.yml**   Engegar com a app els dos serveis conjuntament (kserver i sshd) en una xarxa mynet. Cal
definir apropiadament l'atribut *hostname* per tal de que els containers es trobin.

 
```
docker-compose up -d
Creating network "k18-compose_mynet" with the default driver
Creating kserver.edt.org ... done
Creating sshd.edt.org    ... done

docker ps
CONTAINER ID        IMAGE                    COMMAND                  CREATED             STATUS              PORTS               NAMES
30816d659855        edtasixm11/k18:sshd      "/opt/docker/start..."   31 seconds ago      Up 25 seconds                           sshd.edt.org
4c3f22d1ed94        edtasixm11/k18:kserver   "/opt/docker/start..."   31 seconds ago      Up 26 seconds                           kserver.edt.org

docker network inspect k18-compose_mynet
```


```
ssh local01@172.20.0.3
The authenticity of host '172.20.0.3 (172.20.0.3)' can't be established.
ECDSA key fingerprint is SHA256:miEs80cILd2vxmX5p78ImeI7d+tq1xx7qUxjHNHTCN4.
ECDSA key fingerprint is MD5:6c:93:73:58:9f:ae:48:9f:7c:d6:aa:92:69:11:5b:2a.
Are you sure you want to continue connecting (yes/no)? yes
Warning: Permanently added '172.20.0.3' (ECDSA) to the list of known hosts.
local01@172.20.0.3's password:  local01

[local01@30816d659855 ~] ssh user02@sshd.edt.org
The authenticity of host 'sshd.edt.org (172.20.0.3)' can't be established.
ECDSA key fingerprint is SHA256:miEs80cILd2vxmX5p78ImeI7d+tq1xx7qUxjHNHTCN4.
ECDSA key fingerprint is MD5:6c:93:73:58:9f:ae:48:9f:7c:d6:aa:92:69:11:5b:2a.
Are you sure you want to continue connecting (yes/no)? yes
Warning: Permanently added 'sshd.edt.org,172.20.0.3' (ECDSA) to the list of known hosts.
user02@sshd.edt.org's password: kuser02

[local01@30816d659855 ~]exit 

[local01@30816d659855 ~]$ kinit user02
Password for user02@EDT.ORG: 

[local01@30816d659855 ~]$ klist 
Ticket cache: FILE:/tmp/krb5cc_1000
Default principal: user02@EDT.ORG
Valid starting     Expires            Service principal
02/22/19 17:32:51  02/23/19 17:32:51  krbtgt/EDT.ORG@EDT.ORG

[local01@30816d659855 ~]$ ssh user02@sshd.edt.org
Last login: Fri Feb 22 17:32:08 2019 from 172.20.0.3
user01@sshd ~]$
```

```
docker-compose down
Stopping sshd.edt.org    ... done
Stopping kserver.edt.org ... done
Removing sshd.edt.org    ... done
Removing kserver.edt.org ... done
Removing network k18-compose_mynet
```

## Exemples

### docker-compose.a.yml

Aquest exemple bàsic genera una app amb dos serveis, *kserver* i *sshd* que comparteixen una
xarxa *mynet*.

### docker-compose.b.yml

En aquest exemple s'amplia la app amb un nou servei, el *prtainer*, que permet l'administració
remota de docker. podeu connectar amb el navegador al port local 9000 i un cop establer un nou
password de 8 caràcters podeu observer que tenim tres containers i una xarxa.


### docker-compose.c.yml

En aquest exemple la app consisteix en els serveis *kserver*, *sshd* i *portainer*, però la 
novetat és que el servei *kserver* utilitza un **volume**. Les dades de kerberos es desen 
en un named-volume anomenat *krb5data** que es munta a */var/kerberos*.

Això significa que la base de dades és perdurable, permanent. Els canvis que es fan es desen 
realment al sistema de fitxers del host en un -named-volume de docker. Podem llistar i gestionar
els volums amb l'ordre *docker volume*.

Així per exemple en una execució de la app esborrem *user03* i creem un nou principal *new* 
(ho podem fer des del sshd amb l'administrador pau). Finalitzem la app i l'engegem de nou,
observeu que no hi ha l'usuari *user03* i si hi ha l'usuari *new*

Podem llistar el volum generat:
```
docker volume ls
DRIVER              VOLUME NAME
local               k18-compose_krb5data
```

