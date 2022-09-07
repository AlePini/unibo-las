#!/bin/bash

[[ -z $2 || -z $1 ]] && { echo "Usage: new.sh <username> <password>" }

#Check if first char is lower case
[[ ${1:0:1} =~ [a-z] ]] || { echo "First char not lower case"; exit -1; }

[[ $( echo $1 | grep -e '^[a-z|A-Z|0-9]*$') ]] || { echo "Not valid username, only alpha num char a-z 0-9"; exit -1; }

[[ $(ldapsearch -x -D "cn=admin,dc=labammsis" -w "gennaio.marzo" -H ldap:/// -b "uid=$1,ou=People,dc=labammsis" -s sub) ]] && { echo "user already exists"; exit -1; }

user="
dn: uid=$1,ou=People,dc=labammsis
objectClass: top
objectClass: posixAccount
objectClass: shadowAccount
objectClass: inetOrgPerson
givenName: $1
cn: $1
sn: $1
uid: $1
uidNumber: 10000
gidNumber: 10000
homeDirectory: /home/$1
loginShell: /usr/bin/init.sh
gecos: User
userPassword: {crypt}x"

echo "$user" > /tmp/$1.ldif

group="
dn: cn=$1,ou=Groups,dc=labammsis
objectClass: top
objectClass: posixGroup
cn: $1
gidNumber: 1000"

echo "$group" > /tmp/$1-group.ldif

ldapadd -x -D "cn=admin,dc=labammsis" -w "gennaio.marzo" -H ldap:/// -f /tmp/$1.ldif
ldappasswd -D "cn=admin,dc=labammsis" -w "gennaio.marzo" "uid=dave,ou=People,dc=labammsis" -s "$2"

ldapadd -x -D "cn=admin,dc=labammsis" -w "gennaio.marzo" -H ldap:/// -f /tmp/$1-group.ldif
