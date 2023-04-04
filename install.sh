#!/bin/bash

EMAIL="queen-ssh.my.id"
KEY="25dcbdfd2aa42f3b0d447c897fd989ce05895"
ZONE_ID="827c3471b4f1734d19f1315add1fb306"

curl -sLX GET "https://api.cloudflare.com/client/v4/zones/${ZONE_ID}/dns_records?per_page=500" \
     -H "X-Auth-Email: ${EMAIL}" \
     -H "X-Auth-Key: ${KEY}" \
     -H "Content-Type: application/json" | jq -r '.result[] | .id' | (
  while read id; do
    curl -sLX DELETE "https://api.cloudflare.com/client/v4/zones/${ZONE_ID}/dns_records/${id}" \
      -H "X-Auth-Email: ${EMAIL}" \
      -H "X-Auth-Key: ${KEY}" \
      -H "Content-Type: application/json" -o /dev/null
    echo "DNS record with ID $id has been deleted."
  done
)
