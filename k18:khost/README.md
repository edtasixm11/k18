# Kerberos Server
## @edt ASIX M11-SAD Curs 2018-2019

**edtasixm11/k18:khost** client  kerberos simple. Contacta al 
  servidor *kserver.edt.org*. Permet la autenticació dels 
  usuaris habituals pere, pau (admin), jordi, anna, marta, 
  marta/admin i julia.

Execució:
```
docker netweork create mynet
docker run --name kserver.edt.org -h kserver.edt.org --net mynet -d edtasixm11/k18:kserver
```

