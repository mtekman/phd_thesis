#!/usr/bin/env python3

import sys

pagemetricsfile=sys.argv[1]

debug_pagenums = False

if len(sys.argv)>2:
    debug_pagenums = list(map(int, sys.argv[2:]))

    
color_map = {} # color --> [nums]

def torez(flo):
#    print("##########")
#    print(flo, end=" ")

    flo = "%.3f" % float(flo)
#    print(flo, end=" ")
#    print(float(flo))
    return float(flo)
                        



with open(pagemetricsfile, 'r') as metrics_file:

    for line in metrics_file:
        junk, num, c, m, y, k, junk, junk = line.split()

        num = int(num)
        c = torez(c)
        m = torez(m)
        y = torez(y)
        k = torez(k)

        cm_diff = c - m
        cm_diff = cm_diff if cm_diff > 0 else -cm_diff

        cm_locked = (c==m==0) or (cm_diff < 0.003)
        
        tuple = ( cm_locked, y < 0.005)
        # blue highlights lock c and m, with no Y

        # Debugging
        if debug_pagenums:            
            if num in debug_pagenums:
                print(num, (c,m,y,k), tuple)

        if tuple in color_map:
            color_map[tuple].append(num)
        else:
            color_map[tuple] = [num]


          
# Color pages only
count_color = []
bw_color = []
for color in color_map:
    
    pages = color_map[color]

    if (color != (True,True)):
        count_color += pages
    else:
        bw_color += pages


print("")
print("BW:" , len(bw_color))
print("CL:",  len(count_color))
count_color.sort()
print( count_color )

