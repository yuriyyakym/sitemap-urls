#!/bin/bash

fetch_xml() {
  if [[ $1 == *.gz ]]
  then
    curl -s $1 | gunzip -c
  else
    curl -s $1
  fi
}

parse_xml() {
  xml=`fetch_xml $1`

  locations=$(tr '\n' ' ' <<< "$xml" | perl -nle'print $& while m{(?<=<loc>)(.*?)(?=</loc>)}g')
  sub_xmls=(`grep -e ".xml\(.gz\)\?$" <<< $locations`)
  pages=(`grep -v -e ".xml\(.gz\)\?$" <<< $locations`)

  printf '%s\n' "${pages[@]}" >&1

  for xml_url in "${sub_xmls[@]}"
  do
    parse_xml $xml_url
  done
}

parse_xml $1
