#!/usr/bin/env python3

# We all know what this is...

import math, sys, random

falling_complex = (
    ["c"+str(x) for x in range(1,3) ]
    + ['cX']
    + [ "c"+str(x) for x in range(3,21) ]
    + ['c22']
    + ['c21']
)

bit_size = int(sys.argv[1])

#c1 = 1
#c2 = 0.5
#c3 = 0.05
c1 = 1
c2 = 0.5
c3 = 0.05


def getTime(num, bit_size):

    bitscaler = 1 + (bit_size / 19)
    chromscaler = (23 - num)

    x = bitscaler * chromscaler

    a = 0.00001
    b = 10
    c = bit_size
    # ax^2 + bx + c

    time = (a*math.pow(x, 2)) + (b*x) + c

    

#    time = math.pow( bitscaler, chromscaler )
    
   
    #time = bitscaler * math.pow(rev * bit_size * c1, c2 * math.pow(bit_size * c3, 0.25) )

    #time = time + (-bit_size/2) + (random.random()*(random.random() * bit_size))   
    return time


total = 0

for x in range(len(falling_complex)):

    chrom = falling_complex[x]
    
    num = chrom.split('c')[1]
    if num == "X":
        num = 2.5
    else:
        num = int(num)

    time = getTime(num, bit_size)
    total += time
    print(chrom, "%.2f" % time)

print(total)
