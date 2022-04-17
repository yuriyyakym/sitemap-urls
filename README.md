# sitemap-urls

Bash script for parsing sitemap.xml urls. It supports deep and gzipped sitemaps.

It prints url per line, and can be piped with other unix commands.

### Examples:
```sh
# Get all sitemap urls
./sitemap-urls.sh https://developer.mozilla.org/sitemaps/en-US/sitemap.xml

# Get only urls that end with `.js`
./sitemap-urls.sh https://developer.mozilla.org/sitemap.xml | grep -e "\.js$"

# Get only urls that do not end with `.js`
./sitemap-urls.sh https://developer.mozilla.org/sitemap.xml | grep -v -e "\.js$"

# Get urls and write them to file
./sitemap-urls.sh https://developer.mozilla.org/sitemap.xml > mdn.urls.txt
```
