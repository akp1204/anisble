#!/bin/bash
set -e
source /usr/local/lib/virtualenv/myglos/bin/activate
pushd /var/www/html/glos-catalog
python download_catalog.py
popd
