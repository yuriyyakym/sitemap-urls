# sitemap-urls.sh

This script is used to parse sitemap XML files from a given URL, and output a list of URLs found in the sitemap. It supports both regular and gzipped sitemaps.

## Usage
To run the script, call it from the command line and provide the URL of the sitemap XML file as an argument:

```sh
./sitemap-urls.sh <sitemap_url>
```

## Output
The script will print the list of URLs found in the sitemap to stdout, with each URL on a new line.

## Dependencies
`curl` - used to fetch the sitemap from the URL

`xpath` - used to parse the sitemap XML

## Examples
```sh
# Get all sitemap urls
./sitemap-urls.sh https://developer.mozilla.org/sitemap.xml

# Get only urls that end with `.js`
./sitemap-urls.sh https://developer.mozilla.org/sitemap.xml | grep -e "\.js$"

# Get only urls that do not end with `.js`
./sitemap-urls.sh https://developer.mozilla.org/sitemap.xml | grep -v -e "\.js$"

# Get urls and write them to file
./sitemap-urls.sh https://developer.mozilla.org/sitemap.xml > mdn.urls.txt

# Check pages availability
./sitemap-urls.sh https://developer.mozilla.org/sitemap.xml | xargs -I{} sh -c '
  if curl --output /dev/null --silent --head --fail "$1"; then
    echo "$1 OK"
  else
    echo "$1 BAD"
  fi
' -- {}
```

## License
This script is licensed under the MIT License. See the LICENSE file for more information.
