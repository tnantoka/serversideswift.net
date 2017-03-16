#!/bin/sh
rm -rf docs
spelt build --destination docs
echo "www.serversideswift.net" > docs/CNAME
