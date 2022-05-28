#!/bin/bash

if [[ $1 = "new" && $# -eq 1 ]]; then
  echo "using new"
  exit 0
elif [[ $# -ne 0 ]]; then
  echo "wrong params"
  logger -n 10.20.20.254 -p local1.error "ldap.sh $@"
  exit 1
else
  echo "no params"

  exit 0
fi
