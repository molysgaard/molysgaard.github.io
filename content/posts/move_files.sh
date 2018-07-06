#!/bin/bash
for f in *.md; do 
  mkdir "${f%.md}"
  mv -- "$f" "${f%.md}/$f"
done
