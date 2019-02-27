#! /bin/bash
# @edt ASIX-M06
# -----------------
authconfig --enableshadow --enablelocauthorize --enableldap --ldapserver='ldap.edt.org' --ldapbase='dc=edt,dc=org' --enableldapauth --updateall
