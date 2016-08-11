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

                sentence = word.split()

                if len(sentence)==1:
                    word = sentence[0]
                    sentence = 0
       
                map_of_acros[word]= ("comp:"+word, sentence)

                

            elif line.startswith('\\addglossbio'):
                word = line.split('{')[1].split('}')[0].strip()

                sentence = word.split()
                word = sentence[0]

                if len(sentence)==1:
                    sentence = 0

                map_of_acros[word]= ("bio:"+word, sentence)

                # Programs really only apply to one section
            elif line.startswith('\\addglossprog'):
                word = line.split('{')[1].split('}')[0].strip()

                sentence = word.split()
                word = sentence[0]

                if len(sentence)==1:
                    sentence = 0

                map_of_acros[word]= ("prog:"+word, sentence)

                
        glf.close()

#print(map_of_acros)
#exit(0)


reg = re.compile("^\W+")


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
#            print(words)
            
            w = 0
            while w < len(words):
                wo = words[w]

                # -- Detect existing GLS tags (spanning multiple words)
                # -- and strip them
                gls_index = wo.find('\\gls{')
                if gls_index != -1:
                    # Begin search in subsequent words
                    start_index = w

                    nested_bracket_open = 0  # increments for each {, decrements for }
                    
                    while start_index < len(words):
                        new_word = words[start_index]

                        if new_word.find("{") != -1:
                            nested_bracket_open += 1

                        if new_word.find("}") != -1:
                            nested_bracket_open -= 1

                            # Found our match
                            if nested_bracket_open == 0:
                                start_index += 1
                                break

                        start_index += 1

                    nwo = (' '.join(words[w:start_index])).split('\\gls{')[1]
                    nwo_end = nwo.rfind('}')
                    nwo = nwo[:nwo_end]

                    sentence = nwo.split()
                    key = sentence[0]
                    rest = 0

                    if len(sentence)>1:
                        rest = sentence[1:]
                    
                    # Add to "seen" dictionary
#                    print("velouria: start=[%s] words=|%s| key=[%s] sentence=%s" % (wo, nwo, key, rest), w, start_index)
                    local_map_counter[":".join(nwo.split(':')[1:])] = 1
                    print("Line %3d: seen " % lc, nwo)
                    w = start_index
                    continue

                
                # -- Detect untagged words
                # -- and tag them
                beg_part=""

                regex_word = reg.match(wo)
                if regex_word:
#                    print("MATCH", wo, regex_word.span()[1])
                    split_index = regex_word.span()[1]
                    beg_part = wo[:split_index]
                    wo = wo[split_index:]
                    words[w] = wo
#                    print("MATCH", wo, beg_part, regex_word.span()[1], beg_part)

                if wo not in map_of_acros:
                    words[w] = beg_part + wo    #reset change


                else:
                    key,sentence = map_of_acros[wo]
                    if sentence == 0:   # simple word

                        if wo in local_map_counter:
                            print("Line %3d: Skipping" %lc,wo)
                            w += 1
                            continue  # reference no more than once for each Heading Delim

                        local_map_counter[wo] = 1

                        key = map_of_acros[wo][0]

                        ans = input("Line %3d: tag  %s ? \"%s\" " % (lc,key, words[w-5:w+5]))
                        if ans == "y":
                            words[w] = beg_part + "\\gls{"+ key +"}"
                            modif_made = True

                    else: # Complex word, look ahead
                        print("Line %3d: Complex word?" % lc, key, sentence, end="")
                        iterator  = 0
                        start_index = w + iterator

                        while ((start_index < len(words) and (iterator < len(sentence)))
                               and (
                                   words[start_index].startswith(sentence[iterator])
                                   )
                               ):
#                            print(words[start_index])
                            start_index += 1
                            iterator += 1

                        # Perfect Match!
                        if len(sentence) == iterator:
                            print(" Yep.")
                            last_sentence = sentence[-1]
                            last_word = words[start_index-1]

                            extra_after = last_word.split(last_sentence)
                            
                            if len(extra_after[1])>0:
                                extra_after = "".join(extra_after[1:])
                            else:
                                extra_after = ""

#                            makerword = " ".join(sentence)
                            makerbird = key+" "+" ".join(sentence[1:])

                            if makerbird in local_map_counter:  # already tagged, skip.. :(
                                w += 1
                                continue

                            local_map_counter[makerbird] = 1
                            
                            make_word = beg_part + "\\gls{"+makerbird+"}" + extra_after

                            ans = input("Line %3d: tag [%s] ? \"%s\" " % (lc,make_word, words[w-5:w+5]))

                            if ans=="y":
                                make_split = make_word.split()
                                for m in range(len(make_split)):
                                    words[w+m] = make_split[m]

                                modif_made=True
                                w = start_index
                                continue
                        else:
                            print(" No.")

                w += 1

            if modif_made:
                line = ' '.join(words)

            print(line, file=fnew)





        fill.close()
        fnew.close()


