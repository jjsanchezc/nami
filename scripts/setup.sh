#!/usr/bin/env bash

nologin_path="$(whereis nologin | cut -d ' ' -f 2)" # to make sure whereis
# Create the finance-svc user
useradd finance-svc -s "$nologin_path"

# Create the finance group
# groupadd finance -g 1 -fU finance-svc
groupadd finance -fU finance-svc,jjsanchezc

# Give the permissions to the group
# dir="$PWD"
#groupmod 2755 dir # no estoy seguro de la ubicacion a donde lo debo mandar
