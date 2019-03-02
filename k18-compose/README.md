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

#### docker-compose.d.yml

Desplegar a AWS EC2 usant UNA màquina AMI aquest fitxer "version 3" amb docker stack, que
fa tres rèpliques del servidor i utilitza un volum krb5data.

Connectar manualment a cada ràplica: crear principals new1, new2 i new3 en la primera,
esborrant new3 i creant new4 en la segona i esborrant new2 i creant new5 en la tercera. Observar que
les dades són compatibles entre rèpliques a un mateix host de desplegament.

Aturar l'stack i tornar-lo a engegar i verificar la parmanència de les dades.


```
$ docker stack deploy -c docker-compose.yml  pr

$ docker stack ls
NAME                SERVICES
pr                  2

$docker service ls
ID                  NAME                MODE                REPLICAS            IMAGE                    PORTS
95c5c9vxbc80        pr_kserver          replicated          3/3                 edtasixm11/k18:kserver   
j3aiwlhg1umy        pr_sshd             replicated          1/1                 edtasixm11/k18:sshd      

docker stack ps pr
ID                  NAME                IMAGE                    NODE                                         DESIRED STATE       CURRENT STATE           ERROR               PORTS
q03lc9co0g5m        pr_sshd.1           edtasixm11/k18:sshd      ip-172-31-20-75.eu-west-2.compute.internal   Running             Running 8 minutes ago                       
kni0nntja1k4        pr_kserver.1        edtasixm11/k18:kserver   ip-172-31-20-75.eu-west-2.compute.internal   Running             Running 8 minutes ago                       
nffoes604y8w        pr_kserver.2        edtasixm11/k18:kserver   ip-172-31-20-75.eu-west-2.compute.internal   Running             Running 8 minutes ago                       
n64sq2qkyu0y        pr_kserver.3        edtasixm11/k18:kserver   ip-172-31-20-75.eu-west-2.compute.internal   Running             Running 8 minutes ago                       

$ docker ps       
CONTAINER ID        IMAGE                    COMMAND                  CREATED             STATUS              PORTS               NAMES
bbd8381d6918        edtasixm11/k18:sshd      "/opt/docker/startup…"   6 minutes ago       Up 6 minutes                            pr_sshd.1.q03lc9co0g5m4vezagi6hve0g
94dc82fb73d0        edtasixm11/k18:kserver   "/opt/docker/startup…"   6 minutes ago       Up 6 minutes                            pr_kserver.1.kni0nntja1k4jgb27t7q6m2pg
d71db1cf8ed2        edtasixm11/k18:kserver   "/opt/docker/startup…"   6 minutes ago       Up 6 minutes                            pr_kserver.3.n64sq2qkyu0y7ie8bzu4cfuyr
8cb77d478f7e        edtasixm11/k18:kserver   "/opt/docker/startup…"   6 minutes ago       Up 6 minutes                            pr_kserver.2.nffoes604y8w7tl96xww9ekul

$ docker volume ls
DRIVER              VOLUME NAME
local               pr_krb5data
local               pr_ldapdata

docker stack rm pr
Removing service pr_kserver
Removing service pr_sshd
Removing network pr_mynet
```

Dins un dels containers:
```
$ mount  -t ext4
/dev/xvda1 on /var/kerberos type ext4 (rw,relatime,seclabel,data=ordered)
/dev/xvda1 on /etc/resolv.conf type ext4 (rw,relatime,seclabel,data=ordered)
/dev/xvda1 on /etc/hostname type ext4 (rw,relatime,seclabel,data=ordered)
/dev/xvda1 on /etc/hosts type ext4 (rw,relatime,seclabel,data=ordered)

```

#### docker-compose.d.yml  (bis)

Desplegar en un swarm format per tres màquines AMI de AWS EC2.
En fer el deploy segurament les tres rèpliques de kserver es repertiran en els tres nodes.

```
$ docker stack deploy -c docker-compose.yml  pr

$ docker ps
CONTAINER ID        IMAGE                    COMMAND                  CREATED             STATUS              PORTS               NAMES
8ddd70f07489        edtasixm11/k18:sshd      "/opt/docker/startup…"   2 minutes ago       Up About a minute                       pr_sshd.1.oy78w32rc9vni79asg2tz1wi1
60a219b3ab78        edtasixm11/k18:kserver   "/opt/docker/startup…"   2 minutes ago       Up 2 minutes                            pr_kserver.2.urx8u97jwxicaoqtc1uy2eskh

$ docker stack ps pr
ID                  NAME                IMAGE                    NODE                                         DESIRED STATE       CURRENT STATE           ERROR               PORTS
oy78w32rc9vn        pr_sshd.1           edtasixm11/k18:sshd      ip-172-31-20-75.eu-west-2.compute.internal   Running             Running 2 minutes ago                       
tmh4opomkp8r        pr_kserver.1        edtasixm11/k18:kserver   ip-172-31-30-30.eu-west-2.compute.internal   Running             Running 2 minutes ago                       
urx8u97jwxic        pr_kserver.2        edtasixm11/k18:kserver   ip-172-31-20-75.eu-west-2.compute.internal   Running             Running 2 minutes ago                       
jcp3al2i9pwp        pr_kserver.3        edtasixm11/k18:kserver   ip-172-31-31-57.eu-west-2.compute.internal   Running             Running 2 minutes ago                       

$ docker stack ls
NAME                SERVICES
pr                  2

$ docker service ls
ID                  NAME                MODE                REPLICAS            IMAGE                    PORTS
vlozlf5yds0d        pr_kserver          replicated          3/3                 edtasixm11/k18:kserver   
zg0yndejsuws        pr_sshd             replicated          1/1                 edtasixm11/k18:sshd  
```

A cada host hi ha el volum krb5_data
```
$ docker volume ls
DRIVER              VOLUME NAME
local               pr_krb5data
```
Si anem accedint individualmentr a cada k server observer que el del manager té els usuaris que hem estat
creant (new1, etc). Ha reutilitzat el volum que hi havia en el host. En canvi els altres dos nodes workers 
no tenien volum i l'ha creat de now, en blanc hi ha fet el populate que mana la imatge (els principals habituals).
Qualsevol canvi que fem és local al volume del node.
En conclusió, el disc NO es comparteix!


Cal estudiar solucions de:
 - DRDB
 - GlusterFS
 - NFS
 - Amazon S3


#### docker-compose.e.yml

Desplegar en un host local o a AWS amb docker-compose la app amb els serveis
kserver, sshd i ldap, tot redirigint els ports dels serveis al host. Això 
permet al host actuar com un servidor kerberos, ssh i ldap.

Des de qualsevol client correctament configurar definir al /etc/hosts la 
adreça IP del host i els noms de domini sshd.edt.org, kserver.edt.org i ldap.edt.org.



