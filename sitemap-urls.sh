#!/bin/bash

if ! command -v xpath &> /dev/null; then
  echo "Error: xpath command not found. Please install it and try again."
  exit 1
fi

if ! command -v curl &> /dev/null; then
  echo "Error: curl command not found. Please install it and try again."
  exit 1
fi

if [[ $# -eq 0 ]]; then
  echo "Error: no argument provided."
  echo "Usage: parse_sitemap_xml <sitemap_url>"
  exit 1
fi


# fetch_xml - Fetches an XML file from a URL, optionally decompressing it if it is gzipped
#
# Usage:
#   fetch_xml "url"
#
# Arguments:
#   $1 - The URL of the XML file to fetch
fetch_xml() {
  local url=$1
  local filename=$(basename $url)

  if [[ $filename == *.gz ]]
  then
    curl -s $url | gunzip -c
  else
    curl -s $url
  fi
}


# decode_xml_entities - Decodes HTML entities in an XML or HTML string
#
# Usage:
#   decode_xml_entities "input_string"
#   cat file.xml | decode_xml_entities
#
# Arguments:
#   $1 - The input XML or HTML string to decode
#
# Output:
#   The decoded XML or HTML string, printed to standard output
decode_xml_entities() {
  sed 's/&lt;/</g; s/&gt;/>/g; s/&quot;/"/g; s/&apos;/\x27/g; s/&amp;/\&/g;'
}


# parse_sitemap_xml - Recursively parses a sitemap XML file and outputs the URLs
#
# Usage:
#   parse_sitemap_xml "sitemap_url"
#
# Arguments:
#   $1 - The URL of the sitemap XML file to parse
#
# Output:
#   The URLs of all pages contained within the sitemap, printed to standard output
parse_sitemap_xml() {
  local xml=$(fetch_xml $1)

  # Skip if fetching the XML file failed
  if [ $? -ne 0 ]; then
    return 0
  fi

  local sub_sitemaps=($(echo "$xml" | xpath -q -e "//sitemap/loc/text()" 2>/dev/null | decode_xml_entities))
  local pages=($(echo "$xml" | xpath -q -e "//urlset/url/loc/text()" 2>/dev/null | decode_xml_entities))

  if [ ${#pages[@]} -gt 0 ]; then
    printf '%s\n' "${pages[@]}" >&1
  fi

  for xml_url in "${sub_sitemaps[@]}"
  do
    parse_sitemap_xml $xml_url
  done
}

parse_sitemap_xml $1
