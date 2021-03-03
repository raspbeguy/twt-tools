#!/bin/bash

config="$HOME/.config/twtxt/twtsub.txt"

if [ ! -f $config ]
then
  echo "ERROR: $config not found" > /dev/stderr
  exit 1
fi

while IFS=$'\t' read -r nick url garbage
do
  curl -s "$url" | sed "/^#/d; s#^#$nick\t#"
done < "$config" |
sort -k2 |
while IFS=$'\t' read nick date tweet garbage
do
  color=$(( 0x$(md5sum <<<"$nick" | cut -d' ' -f1) % 6 ))
  color=$(( ${color#-} + 1 ))
  pretty_date="$(date -d "$date" "+%x %X")"
  echo -e "[\e[36m$pretty_date\e[0m] \e[1;3${color}m$nick\e[0m:"
  echo -e "\t$tweet"
  echo
done
