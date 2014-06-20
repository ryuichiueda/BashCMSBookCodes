#!/bin/bash

echo "Content-Type: text/html"
echo
dd bs=${CONTENT_LENGTH}
