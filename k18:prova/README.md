# Kerberos khost
## @edt ASIX M11-SAD Curs 2018-2019

**edtasixm11/k18:khostpl** host amb PAM (AI) kerberos, (PI) ldap. El servidor al que contacta s'ha
  de dir *kserver.edt.org*. El servidor ldap *ldap.edt.org*. Aquest host configura el *system-auth* de pam
  per usar ldap i pam. Configurar system-auth amb *authconfig*.
  
Per generar autenticació PAM kerberos + ldap:

Configuració ldap:
 * onstal·lar openldap-clients.
 * copiar-hi el fitxer de configuració ldap client /etc/openldap/ldap.conf
 * copiar el fitxer de configuració 
 * copiar el fitxer de configuració nscd
 * copiar el fitxer de configuració nsswitch
 * copiar el fitxer de configuració auth.sh
 * engegar el servei nslcd

Configuració Kerberos:
 * instal·lar el paquet client krb5-workstation
 * Copiar-hi la configuració /etc/krb5.conf
 * instal·lar pam_krb5




Execució:
```
docker run --rm --name ldap.edt.org -h ldap.edt.org --net mynet -d edtasixm06/ldapserver:18group
docker run --rm --name kserver.edt.org -h kserver.edt.org --net mynet -d edtasixm11/k18:kserver
docker run --rm --name khost.edt.org -h khost.edt.org --net mynet -it edtasixm11/k18:khostpl
```

####Test:

Verificar ldap:
```
ldapsearch -x -LLL dn
getent passwd pere
getent passwd


```
