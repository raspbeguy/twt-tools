#!/bin/bash

config="$HOME/.config/twtxt/twtpub.ini"

if [ ! -f $config ]
then
  echo "ERROR: $config not found" > /dev/stderr
  exit 1
fi

account=$(crudini --get "$config" DEFAULT default)

while getopts ":a:" option
do
  case option in
    a)
      account="$OPTARG"
      ;;
    *)
      echo "ERROR: unknown option -$option" > /dev/stderr
      exit 1
      ;;
  esac
done

shift $((OPTIND-1))

eval "$(crudini --get --format=sh "$config" "$account")"
tweet="$@"

curl -H "Authorization: Bearer $secret" -d "$tweet" "$api"
