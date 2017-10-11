# sitemap-urls
Bash script for parsing urls from sitemap.xml with either flat or deep structure.

It outputs url per line, therefore it can be combined with other unix commands.

### Examples:
Get all sitemap urls:
```
./sitemap-urls.sh https://developer.mozilla.org/sitemaps/en-US/sitemap.xml
```

Get only urls that end with ___.html___:

```
./sitemap-urls.sh https://developer.mozilla.org/sitemaps/en-US/sitemap.xml | grep -e .html$
```

Get only urls that do not end with ___.html___:
```
./sitemap-urls.sh https://developer.mozilla.org/sitemaps/en-US/sitemap.xml | grep -v -e .html$
```

Get urls and write them to file:
```
./sitemap-urls.sh https://developer.mozilla.org/sitemaps/en-US/sitemap.xml > mdn.urls.txt
```

And so on.
