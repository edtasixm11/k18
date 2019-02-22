# Kerberos
## @edt ASIX M11-SAD Curs 2018-2019

**edtasixm11/k18:sshd** servidor sshd kerberitzat.

 * Té usuaris locals amb passwd tipus local01, local02 i local03.
 * Té usuaris locals sense passwd tipus user01, user02 i user03. Aquests usuaris són principals al ldap.
 * Permet validar que el servidor ssh autentica usuaris locals contra /etc/passwd i usuaris amb comptes 
   locals i passwd al kerberos.

Cal:

 * Crear els comptes locals amb passwd i els locals sense.
 * Crear els principals dels usuaris que tene el passwd al kerberos.
 * Al kerberos cal que estigui creada la entrada de host com a principal (host kerberitzat)
 * Exportar la entrada de host via keytab al servidor ssh.
 * Modificar la configuració de ssh per autenticar *també* via kerberos.


Execució:
```
docker network create mynet
docker run --rm --name kserver.edt.org -h kserver.edt.org --net mynet -d edtasixm11/k18:kserver
###docker run --rm --name khost -h khost --net mynet -it edtasixm11/k18:khost
```

