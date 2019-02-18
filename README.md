# Kerberos
## @edt ASIX M11-SAD Curs 2018-2019

**edtasixm11/k18:kserver** servidor kerberos detach. Crea els usuaris pere
  pau (admin), jordi, anna, marta, marta/admin i julia.
  Assignar-li el nom de host: *kserver.edt.org*

**edtasixm11/k18:khost** host client de kerberos. Simplement amb eines 
  kinit, klist i kdestroy (no pam). El servidor al que contacta s'ha 
  de dir *kserver.edt.org*.

Execució:
```
docker netweork create mynet
docker run --rm --name kserver.edt.org -h kserver.edt.org --net mynet -d edtasixm11/k18:kserver
docker run --rm --name khost -h khost --net mynet -it edtasixm11/k18:khost
```

