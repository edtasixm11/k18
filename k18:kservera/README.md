# Kerberos Server
## @edt ASIX M11-SAD Curs 2018-2019

**edtasixm11/k18:kserver** servidor kerberos detach. Crea els usuaris pere
  pau (admin), jordi, anna, marta, marta/admin i julia.
  Assignar-li el nom de host: kserver.edt.org

Execució:
```
docker netweork create mynet
docker run --name kserver.edt.org -h kserver.edt.org --net mynet -d edtasixm11/k18:kserver
```

