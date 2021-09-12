#!/bin/bash

EMAIL=queen-ssh.my.id
KEY=25dcbdfd2aa42f3b0d447c897fd989ce05895
ZONE_ID=2222222222222222222222222

curl -sLX GET https://api.cloudflare.com/client/v4/zones/${ZONE_ID}/dns_records?per_page=500 \
     -H "X-Auth-Email: ${EMAIL}" \
     -H "X-Auth-Key: ${KEY}" \
     -H "Content-Type: application/json" | jq .result[].id |  tr -d '"' | (
  while read id; do
    curl -sLX DELETE https://api.cloudflare.com/client/v4/zones/${ZONE_ID}/dns_records/${id} \
      -H "X-Auth-Email: ${EMAIL}" \
      -H "X-Auth-Key: ${KEY}" \
      -H "Content-Type: application/json"
  done
  )