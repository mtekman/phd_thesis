#!/usr/bin/env python3


def breadthFirst(node,queue = []):

	print(node.id, end=" ")

	for child in node.children:
		queue.append( child )

	for q in queue:
		breadthFirst(q)	
	

	


def depthFirst(node,level):
#	print("%d[%d]" % (node.id, level), end="")
	print("%d " % (node.id), end="")

	if node.children == 0:
		return 0;

#	print(" [", end="")
	for child in node.children:
#		print(" ",end="")
		depthFirst( child, level + 1)

#	print(" ]", end="")
	return 0


class Node:

	def __init__(self, id, children = 0):
		self.id = id
		self.children = children


graphic = '''

        0
      /   \\
     1     2
    /|\\   /|\\
   3 4 5 6 7 8
    /|     |\\  
   9 10   11 12 
   |       |
  13      14
   |\\
  15 16
'''



root = Node(0,[

    Node(1, [\
       Node(3),\
       Node(4,[\
              Node(9, [\
                   Node(13, [\
                        Node(15), Node(16)\
                   ]),\
              ]),\
              Node(10)\
       ]),\
       Node(5)\
    ]),

    Node(2, [\
       Node(6),\
       Node(7,[\
              Node(11,[\
                   Node(14)\
              ]),\
              Node(12)\
       ]),
       Node(8)\
   ])\
])


print(graphic)
depthFirst(root, 0)
#breadthFirst(root)
print("")
