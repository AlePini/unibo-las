# ldapsearch
- autenticazione locale: -Y EXTERNAL -H ldapi:///
- autenticazione LDAP: -x -H ldap://*host* -D *user* -w *password* **user** cn=admin,dc=labammsis
- base DN: -b "dc=labammsis"

esempio di comando
```bash
# cercare una persona
ldapsearch -x -D "cn=admin,dc=labammsis" -w "gennaio.marzo" -H ldap:/// -b "uid=temp,ou=People,dc=labammsis" -s sub
# cercare tutti i gruppi
ldapsearch -x -D "cn=admin,dc=labammsis" -w "gennaio.marzo" -H ldap:/// -b "ou=Groups,dc=labammsis" -s sub -LLL

ldapsearch -x -D "cn=admin,dc=labammsis" -w "gennaio.marzo" -H ldap://<IP>/ -b "dc=labammsis" -s sub

ldapsearch -x -b "dc=labammsis" -s sub -LLL
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
gidNumber: 1000
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
uidNumber: 1000
gidNumber: 1000
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
ldappasswd -D "cn=admin,dc=labammsis" -w gennaio.marzo -H ldap://10.2.2.2/ "uid=dave,ou=People,dc=labammsis" -s "ciaociao"
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
add user to group
```
dn: cn=dave,ou=Groups,dc=labammsis
changetype: modify
add: memberUid
memberUid: dave
```
```bash
ldapmodify -x -D "cn=admin,dc=labammsis" -w "gennaio.marzo" -H ldap:/// -f change.ldiff
```

### LDAP remoto
`/etc/ldap/ldap.conf`
```bash
BASE    dc=labammsis
URI     ldapi://ip-server-ldap/
```

**Ricorda che se dice password corretta, ma non ti fa loggare e ti riporta a vagrant@hostname, devi fare:**
```bash
sudo systemctl restart nscd
```