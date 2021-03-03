#!/bin/bash

secret="change me"

function urldecode {
  local url_encoded="${1//+/ }"
  printf '%b' "${url_encoded//%/\\x}"
}

function post_do {
  echo "$HTTP_AUTHORIZATION" > /tmp/azerty
  if [ "$HTTP_AUTHORIZATION" = "Bearer $secret" ]
  then
    echo "Content-Type: text/plain; charset=utf-8"
    echo
    read tweet
    printf '%b\t%b\n' "$(date --iso-8601=seconds)" "$(urldecode "$tweet")" >> twtxt.txt
    echo "OK"
  else
    echo "Status: 401 Unauthorized"
    echo "Content-Type: text/plain; charset=utf-8"
    echo
    echo "Pas cool"
  fi
}

case $REQUEST_METHOD in
  "POST") post_do ;;
  *)
    echo "Status: 403 Forbidden"
    echo "Content-Type: text/plain; charset=utf-8"
    echo
    echo "You should use POST instead"
    ;;
esac
