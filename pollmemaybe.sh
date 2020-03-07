#!/bin/bash

team="$(hostname)"
ip="$(hostname -I)"
curl "http://maslab.mit.edu/pollmemaybe/?team=${team}&ip=${ip}">/dev/null
