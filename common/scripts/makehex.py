#!/usr/bin/env python3
#
# This is free and unencumbered software released into the public domain.
#
# Anyone is free to copy, modify, publish, use, compile, sell, or
# distribute this software, either in source code form or as a compiled
# binary, for any purpose, commercial or non-commercial, and by any
# means.
import sys
from sys import argv

binfile = argv[1]
nwords = int(argv[2])

with open(binfile, "rb") as f:
    bindata = f.read()

assert len(bindata) < 4*nwords
remaining_bytes = len(bindata) % 4



    
# assert len(bindata) % 4 == 0, "Number of byte {l} not divisible by 4 ".format(l=len(bindata))

for i in range(nwords):
    if i < len(bindata) // 4:
        w = bindata[4*i : 4*i+4]
        print("%02x%02x%02x%02x" % (w[3], w[2], w[1], w[0]))    
    elif i ==  len(bindata) // 4:
        if remaining_bytes == 3:
            w = bindata[4*i : 4*i+3]
            print("%02x%02x%02x%02x" % (0, w[2], w[1], w[0]))    
        elif remaining_bytes == 2:
            w = bindata[4*i : 4*i+2]
            print("%02x%02x%02x%02x" % (0, 0, w[1], w[0]))    
        elif remaining_bytes == 1:
            w = bindata[4*i : 4*i+1]
            print("%02x%02x%02x%02x" % (0, 0, 0, w[0]))    

    else:
        print("0")

