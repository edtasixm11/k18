#! /bin/bash
# @edt ASIX-M11
# -----------------
authconfig  --enableshadow --enablelocauthorize --enableldap  --ldapserver='ldap' --ldapbase='dc=escoladeltreball,dc=org' --enableldapauth  --updateall

