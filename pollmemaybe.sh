#!/bin/bash

team="$(hostname)"
ip="$(hostname -I | cut -d' ' -f1)"
curl "http://maslab.mit.edu/pollmemaybe/?team=${team}&ip=${ip}">/dev/null
