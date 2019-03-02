# SAMBA
## @edt ASIX M06 2018-2019

Podeu trobar les imatges docker al Dockehub de [edtasixm06](https://hub.docker.com/u/edtasixm06/)

Podeu trobar la documentació del mòdul a [ASIX-M06](https://sites.google.com/site/asixm06edt/)


ASIX M06-ASO Escola del treball de barcelona

### Imatges:

* **edtasixm06/samba:18detach** Servidor SAMBA amb usuaris locals i usuaris LDAP (unix). 
Es creen comptes d'usuari samba de usuaris locals i de alguns dels usuaris ldap (no tots).
Es creen també els directoris home dels usuaris de ldap i se'ls assigna la pripietat/grup
pertinent.
Finalment s'exporten els *shares* d'exemple usuals i els **[homes]** dels usuaris samba.
D'aquesta manera un hostpam (amb ldap) pot muntar els homes dels usuaris (home dins home) 
usant samba.

És el mateic que el samba:18ldapusers però amb un bucle *cutre* que el deixa en background per 
executar-se detach.

### Arquitectura

Per implementar un host amb usuaris unix i ldap on els homes dels usuaris es muntin via samba de un 
servidor de disc extern cal:

  * **sambanet** Una xarxa propia per als containers implicats.

  * **ldapserver** Un servidor ldap en funcionament amb els usuaris de xarxa.

  * **samba** Un servidor samba que exporta els homes dels usuaris com a shares via *[homes]*
Caldrà fer les tasques següents en el servidor samba:

    * *Usuaris unix* Samba requereix la existència de usuaris unix. Per tant caldrà disposar dels usuaris unix,
poden ser locals o de xarxa via LDAP. Així doncs, el servidor samba ha d'estar configurat amb nscd i nslcd per
poder accedir al ldap. Amb getent s'han de poder llistar tots els usuaris i grups de xarxa.

    * *homes* Cal que els usuaris tinguin un directori home. Els usuaris unix local ja en tenen en crear-se
l'usuari, però els usuaris LDAP no. Per tant cal crear el directori home dels usuaris ldap i assignar-li la 
propietat i el grup de l'usuari apropiat.

    * *Usuaris samba* Cal crear els comptes d'usuari samba (recolsats en l'existència del mateix usuari unix).
Per a cada usuari samba els pot crear amb *smbpasswd* el compte d'usuasi samba assignant-li el password de samba.
Convé que sigui el mateix que el de ldap per tal de que en fer login amb un sol password es validi l'usuari (auth de
pam_ldap.so) i es munti el  home via samba (pam_mount.so).
Samba pot desar els seus usuaris en una base de dades local anomenada **tdbsam** o els pot desar en un servidor ldap 
usant com a backend **ldapsam**. El mecanisme més simple és usar *tdbsam* i *smbpasswd* i *pdbedit* com a utilitats.

  * **hostpam** Un hostpam configurat per accedir als usuarislocals i ldap i que usant pam_mount.so
munta dins del home dels usuaris un home de xarxa via samba. Cal configurar */etc/security/pam_mount.conf.xml* 
per muntar el recurs samba dels *[homes]*.



#### Execució

```
docker network create sambanet
docker run --rm --name ldap -h ldap --net sambanet -d edtasixm06/ldapserver:18group

#docker run --rm --name samba -h samba --net sambanet -it edtasixm06/samba:18ldapusers 
docker run --rm --name samba -h samba --net sambanet -d edtasixm06/samba:18detach 

docker run --rm --name host -h host --net sambanet -it edtasixm06/hostpam:18homenfs  #canviar per :18homesamba


```

#### Configuració samba clau

```
[global]
        workgroup = MYGROUP
        server string = Samba Server Version %v
        log file = /var/log/samba/log.%m
        max log size = 50
        security = user
        passdb backend = tdbsam
        load printers = yes
        cups options = raw
[homes]
        comment = Home Directories
        browseable = no
        writable = yes
;       valid users = %S
;       valid users = MYDOMAIN\%S
```


#### Configuració en el hostpam

*/etc/security/pam_mount.conf.xml*
```
<volume user="*" fstype="cifs" server="samba" path="%(USER)"  mountpoint="~/%(USER)" />

```

#### Exemple en el hostpam
```
[root@host docker]# su - local01

[local01@host ~]$ su - anna
pam_mount password:

[anna@host ~]$ ll
total 0
drwxr-xr-x+ 2 anna alumnes 0 Dec 14 20:27 anna

[anna@host ~]$ mount -t cifs
//samba2/anna on /tmp/home/anna/anna type cifs (rw,relatime,vers=1.0,cache=strict,username=anna,domain=,uid=5002,forceuid,gid=600,forcegid,addr=172.21.0.2,unix,posixpaths,serverino,mapposix,acl,rsize=1048576,wsize=65536,echo_interval=60,actimeo=1)
```

