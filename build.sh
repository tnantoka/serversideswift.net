#!/bin/sh
rm -rf docs

echo 'google_analytics: "UA-75934247-1"' >> _config.yml
echo 'disqus_shortname: "serversideswift-net"' >> _config.yml
echo 'ad: 1' >> _config.yml

spelt build --destination docs
echo "www.serversideswift.net" > docs/CNAME

git checkout _config.yml

