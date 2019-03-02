#! /bin/bash
# @edt ASIX M06 2018-2019
# instal.lacio
# -------------------------------------
groupadd localgrp01
groupadd localgrp02
useradd -g users -G localgrp01 local01
useradd -g users -G localgrp01 local02
useradd -g users -G localgrp01 local03
useradd -g users -G localgrp02 local04
useradd -g users -G localgrp02 local05
useradd -g users -G localgrp02 local06
echo "local01" | passwd --stdin local01
echo "local02" | passwd --stdin local02
echo "local03" | passwd --stdin local03
echo "local04" | passwd --stdin local04
echo "local05" | passwd --stdin local05
echo "local06" | passwd --stdin local06

#bash /opt/docker/auth.sh
cp /opt/docker/nslcd.conf /etc/nslcd.conf
cp /opt/docker/ldap.conf /etc/openldap/ldap.conf
cp /opt/docker/nsswitch.conf /etc/nsswitch.conf
#cp /opt/docker/system-auth-edt /etc/pam.d/system-auth-edt
#cp /opt/docker/pam_mount.conf.xml /etc/security/pam_mount.conf.xml
#ln -sf /etc/pam.d/system-auth-edt /etc/pam.d/system-auth

/usr/sbin/nslcd && echo "nslcd Ok"
/usr/sbin/nscd && echo "nscd Ok"

# -----------------------------------------------------------
mkdir /tmp/home
mkdir /tmp/home/pere
mkdir /tmp/home/pau
mkdir /tmp/home/anna
mkdir /tmp/home/marta
mkdir /tmp/home/jordi
mkdir /tmp/home/admin

cp README.md /tmp/home/pere
cp README.md /tmp/home/pau
cp README.md /tmp/home/anna
cp README.md /tmp/home/marta
cp README.md /tmp/home/jordi
cp README.md /tmp/home/admin

chown -R pere.users /tmp/home/pere
chown -R pau.users /tmp/home/pau
chown -R anna.alumnes /tmp/home/anna
chown -R marta.alumnes /tmp/home/marta
chown -R jordi.users /tmp/home/jordi
chown -R admin.wheel /tmp/home/admin

# -----------------------------------------------------------
mkdir /var/lib/samba/public
chmod 777 /var/lib/samba/public
cp /opt/docker/* /var/lib/samba/public/.

mkdir /var/lib/samba/privat
#chmod 777 /var/lib/samba/privat
cp /opt/docker/smb.conf /etc/samba/smb.conf
cp /opt/docker/*.md /var/lib/samba/privat/.

useradd patipla
useradd lila
useradd roc
useradd pla

echo -e "patipla\npatipla" | smbpasswd -a patipla
echo -e "lila\nlila" | smbpasswd -a lila
echo -e "roc\nroc" | smbpasswd -a roc
echo -e "pla\npla" | smbpasswd -a pla
echo -e "kpere\nkpere" | smbpasswd -a pere
echo -e "kpau\nkpau" | smbpasswd -a pau
echo -e "kanna\nkanna" | smbpasswd -a anna
echo -e "kmarta\nkmarta" | smbpasswd -a marta
echo -e "kjordi\nkjordi" | smbpasswd -a jordi
echo -e "kadmin\nkadmin" | smbpasswd -a admin
echo "Ok users"
