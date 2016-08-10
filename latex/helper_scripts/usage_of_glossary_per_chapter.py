#!/usr/bin/env python3

import sys,re

map_of_acros={}

if len(sys.argv) < 3:
    print('''
Adds glossary \\gls{} tags around detected glossary words but only for the first instance in that Chapter (document)

    %s <glossary1.tex>+<glossary2.tex> <Section/blah.tex>''' % sys.argv[0], file=sys.stderr)
    exit(-1)


gloss_files=sys.argv[1]
other_files=sys.argv[2:]


for gloss in gloss_files.split('+'):


    with open(gloss,'r') as glf:

        for line in glf:

            if line.startswith('\\addglosscomp'):
                word = line.split('{')[1].split('}')[0].strip()
                map_of_acros[word]= "comp:"+word

            elif line.startswith('\\addglossbio'):
                word = line.split('{')[1].split('}')[0].strip()
                map_of_acros[word]= "bio:"+word

                # Programs really only apply to one section
#            elif line.startswith('\\addglossprog'):
#                word = line.split('{')[1].split('}')[0].strip()
#                map_of_acros[word]= "prog:"+word

                
        glf.close()




for f in other_files:

    fnew = open(f+".new.tex","w")
    
    with open(f,'r') as fill:

        local_map_counter = {}
        lc = 0

        for line in fill:


            modif_made = False
            
            lc += 1

            line = line.splitlines()[0]
            words = line.split()


            # Iterate through words
            w = 0
            while w < len(words):
                wo = words[w]


                #  Detect existing GLS tags (spanning multiple words)
                #  and strip them
                if wo.find('\\gls{') != -1:

                    start_index = w
                    
                    while start_index < len(words):
                        new_word = words[start_index]

                        if new_word.find("}") != -1:
                            start_index += 1
                            break

                        start_index += 1

                    nwo = (' '.join(words[w:start_index])).split('\\gls{')[1]
                    nwo_end = nwo.find('}')
                    nwo = nwo[:nwo_end]
                    nwo = ':'.join(nwo.split(':')[1:])

                    # Add to "seen" dictionary
#                    print("velouria", wo,nwo, w, start_index)
                    local_map_counter[nwo] = 1
                    w = start_index
                    continue

                
                # Untagged word gets modified
                # 
                if wo in map_of_acros:

                    if wo in local_map_counter:
                        w += 1
                        continue  # reference no more than once for each Heading Delim

                    local_map_counter[wo] = 1

                    ans = input("tag %s ? " % wo)
                    if ans == "y":
                        words[w] = "\\gls{"+map_of_acros[wo]+"}"
                        print("line %d modified" % lc, wo)
                        modif_made = True

                w += 1
#                print(w, len(words))

            if modif_made:
                line = ' '.join(words)

            print(line, file=fnew)





        fill.close()
        fnew.close()



