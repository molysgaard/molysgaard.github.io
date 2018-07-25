#!/bin/bash
COMMIT=`git rev-parse --short HEAD`
ghp-import -b master _site -m "./push.sh: Updated webpage $COMMIT"
