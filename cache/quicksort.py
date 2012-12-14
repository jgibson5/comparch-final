def quicksort(l):
	if len(l) <= 1:
		return l

	pivot = l[0]

	lesser = []
	greater = []

	for x in l:
		if x <= pivot:
			lesser.append(x)
		else:
			greater.append(x)
	print lesser
	print greater
	#return quicksort(lesser) + quicksort(greater)