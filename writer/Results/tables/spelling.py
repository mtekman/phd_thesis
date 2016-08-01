#!/usr/bin/env python3

file='data.table'


with open(file,'r') as f:

        header = '\t'.join(f.readline().split('\t')[2:]).splitlines()[0]
        
        for line in f:

                line = line.splitlines()[0]
                tokens = line.split('\t')

                try:
                        token = int(tokens[0])

                        outfile="data_%d.table" % token
                        out = open(outfile,'w')

                        print(header, file=out)
                        print('\t'.join(tokens[2:]), file=out)
                        [ print('\t'.join(f.readline().splitlines()[0].split('\t')[2:]), file=out) for x in range(3)]

                        print(token)
                        out.close()
                except ValueError:
                        pass

