#!/bin/bash

../templateReplacer.rb tdok.txt
sed -e '/upcoming_gigs_replaced/ {' -e 'r tdok.txt.replaced' -e 'd' -e '}' bigdocument.toreplace > bigdocument.html