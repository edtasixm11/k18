# Kerberos khost
## @edt ASIX M11-SAD Curs 2018-2019

**edtasixm11/k18:khost** host client de kerberos. Simplement amb eines
  kinit, klist i kdestroy (no pam). El servidor al que contacta s'ha
  de dir *kserver.edt.org*.
  

**Bàsic:**

Host client de kerberos. Per generar un host client bàsic, que permei accedir al servidor
per verificar la connexió i obtenir tickets, cal:

 * instal·lar krb5-workstation
 * configurar /etc/krb5.conf

Execució:
```
docker run --rm --name khost.edt.org -h khost.edt.org --net mynet -s edtasixm11/k18:khost
```

