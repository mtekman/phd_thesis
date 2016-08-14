#!/usr/bin/env python3

import sys


block_rez = 5000000000
multiplier = 1000000

block_rez = int(sys.argv[1])
multiplier = int(sys.argv[2])


def torez(flo):

    print("##########")
    print(flo, end=" ")

    flo = "%.2f" % float(flo)
    print(flo, end=" ")

    print(float(flo))



torez("0.03508")
torez("0.01741")
torez("0.03562")
torez("0.00103")
torez("0.00039")
torez("0.1537")
torez("0.00056")
torez("0.0")
torez("0.03409")
torez("0.03573")
torez("0.03825")
