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

