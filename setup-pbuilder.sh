#!/usr/bin/env bash

if [ ! -f /var/cache/pbuilder/base.tgz ]; then
    pbuilder create --distribution sid
fi
