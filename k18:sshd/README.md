# SSHD Kerberitzat
## @edt ASIX M11-SAD Curs 2018-2019

**edtasixm11/k18:sshd** Servidor SSHD *kerberitzat*. Servidor ssh que permet
  l'accés d'usuaris locals i usuaris locals amb autenticació kerberos. El
  servidor s'ha de dir sshd.edt.org.

Per fer que el servidor sshd sigui *kerberos aware* cal:

 * instal·lar.hi el paquet krb5-workstation.

 * copiar el fitxerd e configuració kerberos client */etc/krb5.conf*.

 * crear un principal al servidor kerberos coresponent al host sshd. En aquest cas concret es crea
  una entrada *host/sshd.edt.org*.

 * propagar aquest principal (de host)  al keytab del servidor sshd. Aquí s'utilitza un mecanisme 
  *pèssim*, des del client, desatesament, es connecta amb usuari i passwd (text pla) via *kadmin* al
  servidor kerberos i exporta les claus del principal *host/sshd.edt.org* via *ktadd*.

 * configurar el servidor sshd per permetre l'autenticació kerberos, cal modificar el fitxer de 
 configuració del servei */etc/ssh/sshd_config*:

```
# Kerberos options
KerberosAuthentication yes
KerberosTicketCleanup yes
```

**Atenció:**

Si el principal de host que s'ha creat al servidor kerberos és *host/sshd.edt.org* es podrà realitzar
l'accés kerberitzat **només** si es connecta al servidor usant aquest hosname. És a dir, amb les ordres:
```
ssh user01@sshd.edt.org  (OK)
ssh user01@localhost     (NO!)
```
La primera d'elles peermetrà l'accés kerberitzat, la segona no.

```

Execució:
```
docker run --rm --name sshd.edt.org    -h sshd.edt.org    --net mynet -d edtasixm11/k18:sshd
```

