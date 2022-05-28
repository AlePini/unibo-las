# ldapsearch
- autenticazione locale: -Y EXTERNAL -H ldapi:///
- autenticazione LDAP: -x -H ldap://*host* -D *user* -w *password*
  - **user** cn=admin,dc=labammsis
- base DN: -b "dc=labammsis"
esempio di comando
```bash
ldapsearch -x -D "cn=admin,dc=labammsis" -w "gennaio.marzo" -H ldap://10.2.2.2/ -b "dc=labammsis" -s sub
```
ricerca con filtro (OPERATORE_LOGICO( CRITERIO_1 )( CRITERIO_2 ))
```bash
ldapsearch -Y EXTERNAL -H ldapi:/// -b "dc=labammsis" "(&(objectClass=*)(uid=dave))"
```
## create ldiff
```bash
ldapsearch −x −LLL −D cn=admin,dc=labammsis −b ou=People,dc=labammsis -s one −w gennaio.marzo −H ldapi:///
```
# ldappadd
add OU
```text
dn: ou=People,dc=labammsis
objectClass: organizationalunit
ou: People
description: system users
```
add group
```
dn: cn=dave,ou=Groups,dc=labammsis
objectClass: top
objectClass: posixGroup
cn: dave
gidNumber: 2000
```
add user
```text
dn: uid=dave,ou=People,dc=labammsis
objectClass: top
objectClass: posixAccount
objectClass: shadowAccount
objectClass: inetOrgPerson
givenName: Davide
cn: Davide
sn: Berardi
mail: davide.berardi@unibo.it
uid: dave
uidNumber: 2000
gidNumber: 2000
homeDirectory: /home/dave
loginShell: /bin/bash
gecos:Davide "Dave" Berardi
userPassword: {crypt}x
```
add entry
```bash
ldapadd -x -D "cn=admin,dc=labammsis" -w "gennaio.marzo" -H ldap:/// -f file.ldif
```
# ldappasswd
change password
```bash
ldappasswd -D cn=admin,dc=labammsis -w gennaio.marzo -H ldap://10.2.2.2 uid=dave,ou=People,dc=labammsis -s ciaociao
```
# ldapmodify
cambio un parametro
change.ldiff
```
dn: uid=dave,ou=People,dc=labammsis
changetype: modify
replace: uidNumber
uidNumber: 2000
```
```bash
ldapmodify -x -D "cn=admin,dc=labammsis" -w "gennaio.marzo" -H ldap:/// -f change.ldiff
```
