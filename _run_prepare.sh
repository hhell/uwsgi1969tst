#!/bin/sh -x

set -Eeu

# The non-virtualenv packages:
sudo apt-get install \
    python2.7-dbg=2.7.12-1ubuntu0~16.04.4 \
    python-virtualenv

rm -r .env || true
python2.7-dbg -m virtualenv .env --system-site-packages
. ./.env/bin/activate
pip install \
    -r requirements.txt
pip install \
    -r requirements.txt \
    -e ./
