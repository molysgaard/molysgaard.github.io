#!/usr/bin/bash
pandoc -o cv_morten_lysgaard.pdf --template=cv_latex.template.tex --read=markdown+grid_tables -t latex content/pages/cv.md
