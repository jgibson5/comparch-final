import sys

print (sys.argv)

f = open(sys.argv[1] , 'r')
f2 = open("pretty_" + sys.argv[1], 'w')

for line in f:
  for i in range(len(line)/8):
    if line != "":
      f2.write(line[8*i:8*(i+1)] + "\n")







