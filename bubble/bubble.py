f = open("bubble.txt", 'w')
f2 = open("other_bubble.txt", 'w')
wid = 32
num = 32



for i in range(num):
  if (i % 2 ==0):
    low = str(wid*i+num-1)+":"+str(wid*i)
    high = str(wid * (i+1) + num - 1) + ":" + str(wid * (i+1))  
    s = "  outArray["+high+"] <= (outArray["+high+"] > outArray["+low+"])?(outArray["+high+"]):(outArray["+low+"]);\n"

    s += "  outArray["+low+"] <= (outArray["+high+"] > outArray["+low+"])?(outArray["+low+"]):(outArray["+high+"]);\n"
  
    f.write(s)

  elif( i < num -1):
    low = str(wid*i+num-1)+":"+str(wid*i)
    high = str(wid * (i+1) + num - 1) + ":" + str(wid * (i+1))  
    s = "  outArray["+high+"] <= (outArray["+high+"] > outArray["+low+"])?(outArray["+high+"]):(outArray["+low+"]);\n"

    s += "  outArray["+low+"] <= (outArray["+high+"] > outArray["+low+"])?(outArray["+low+"]):(outArray["+high+"]);\n"
  
    f2.write(s)
f.close()
f2.close()
