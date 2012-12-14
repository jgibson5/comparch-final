from quicksort import *
import random, time, copy, sys
import matplotlib.pyplot as m

class Test(object):
	"""docstring for Test"""
	filler = """fillerfillerfillerfillerfillerfiller
						 fillerfillerfillerfillerfillerfiller
						 fillerfillerfillerfillerfillerfiller
						 fillerfillerfillerfillerfillerfiller
						 fillerfillerfillerfillerfillerfiller
						 fillerfillerfillerfillerfillerfiller
						 fillerfillerfillerfillerfillerfiller
						 fillerfillerfillerfillerfillerfiller
						 fillerfillerfillerfillerfillerfiller
						 fillerfillerfillerfillerfillerfiller
						 fillerfillerfillerfillerfillerfiller
						 fillerfillerfillerfillerfillerfiller
						 fillerfillerfillerfillerfillerfiller
						 fillerfillerfillerfillerfillerfiller
						 fillerfillerfillerfillerfillerfiller
						 fillerfillerfillerfillerfillerfiller
						 fillerfillerfillerfillerfillerfiller
						 fillerfillerfillerfillerfillerfiller
						 fillerfillerfillerfillerfillerfiller
						 fillerfillerfillerfillerfillerfiller
						 fillerfillerfillerfillerfillerfiller
						 fillerfillerfillerfillerfillerfiller
						 fillerfillerfillerfillerfillerfiller
						 fillerfillerfillerfillerfillerfiller
						 fillerfillerfillerfillerfillerfiller
						 fillerfillerfillerfillerfillerfiller
						 fillerfillerfillerfillerfillerfiller
						 fillerfillerfillerfillerfillerfiller
						 fillerfillerfillerfillerfillerfiller
						 fillerfillerfillerfillerfillerfiller
						 fillerfillerfillerfillerfillerfiller
						 fillerfillerfillerfillerfillerfiller
						 fillerfillerfillerfillerfillerfiller"""

	def __init__(self, arg):
		self.arg = arg

	def __str__(self):
		return self.arg

	def filler1():
		pass

	def filler2():
		pass

	def filler3():
		pass

	def filler4():
		pass


def timeIt(func):
	def wrapper(*arg):
		t0 = time.time()
		res = func(*arg)
		t1 = time.time()
		dt = (t1-t0) * 1000.0
		print "%s with length %d took %0.3f ms" % \
			   (func.func_name, len(arg[0]), dt)
		return (res, dt)
	return wrapper

def genList(length):
	l = []
	for i in xrange(int(length)):
		l.append(Test(random.randint(0,100)))
	return l

@timeIt
def qWrapper(l):
	return bubblesort(l)

def quicksort(l):
	if len(l) <= 1:
		return l

	pivot = l[0].arg
	lesser = []
	greater = []

	for i in range(1, len(l)):
		x = l[i]
		if x.arg < pivot:
			lesser.append(x)
		else:
			greater.append(x)

	return quicksort(lesser) + [pivot] + quicksort(greater)

def bubblesort(l):
	for i in range(0, len(l) - 1):
		swap_test = False
		for j in range(0, len(l) - i - 1):
			if l[j] > l[j + 1]:
				l[j], l[j + 1] = l[j + 1], l[j] # swap
				swap_test = True
		if swap_test == False:
			break
	return l

def plot(d):
	xs = []
	ys = []
	vals = d.items()
	# print vals
	vals.sort(key=lambda x: x[0])
	# print vals
	for k, v in vals:
		xs.append(k)
		avg = sum(v) / len(v)
		ys.append(avg)
	# print xs, ys
	m.plot(xs, ys)
	m.xlabel("List Size")
	m.ylabel("Time (ms)")
	m.show()


if __name__ == "__main__":
	sys.setrecursionlimit(100000)
	d = {}
	t = Test(10)
	# print sys.getsizeof(t)
	# print sys.getsizeof(10)
	for i in xrange(0,2000):
		for j in xrange(50):
			l = genList(i)
			q, dt = qWrapper(l)
			d[i] = d.get(i, [])
			d[i].append(dt)
	
	plot(d)
