#!/usr/bin/bash
pandoc -o cover_letters/nuro/cover_leter_morten_lysgaard.pdf --template=cv_latex.template.tex --read=markdown+grid_tables+footnotes -t latex cover-letters/nuro/nuro.md
