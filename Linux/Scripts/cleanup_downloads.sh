#!/bin/bash

0 18 * * * mv ~/Downloads/doctors*.docx /usr/share/doctors >/dev/null 2>&1
0 18 * * * mv ~/Downloads/patients*.txt /usr/share/patients >/dev/null 2>&1
0 18 * * * mv ~/Downloads/treatment*.pdf /usr/share/treatments >/dev/null 2>&1

