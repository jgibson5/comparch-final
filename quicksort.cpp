#include <iostream>
#include <stdio.h>
#include <time.h>
#include <algorithm>
using namespace std;

# define  MAX_LEVELS  3000
void shuffle(int *arr,int size)
{
    int random = 0;
    srand ( time(NULL) );
    int k=0;
    for (k=0;k<size;k++)
    {
        random = rand() % 1000 + 1;
        arr[k] = random;
    }
}
void printarr(int *arr,int size)
{
  for (int i=0;i<size;i++)
  {
      printf("%i - ",arr[i]);
  }   
  printf("\n");
}

//merge sort  ---------------------------------
void m_sort(int *numbers, int *temp, int left, int right);
void merge(int *numbers, int *temp, int left, int mid, int right);
void mergeSort(int *numbers, int *temp, int array_size)
{
  m_sort(numbers, temp, 0, array_size - 1);
}
 
void m_sort(int *numbers, int *temp, int left, int right)
{
  int mid;
 
  if (right > left)
  {
    mid = (right + left) / 2;
    m_sort(numbers, temp, left, mid);
    m_sort(numbers, temp, mid+1, right);
 
    merge(numbers, temp, left, mid+1, right);
  }
}
 
void merge(int *numbers, int *temp, int left, int mid, int right)
{
  int i, left_end, num_elements, tmp_pos;
 
  left_end = mid - 1;
  tmp_pos = left;
  num_elements = right - left + 1;
 
  while ((left <= left_end) && (mid <= right))
  {
    if (numbers[left] <= numbers[mid])
    {
      temp[tmp_pos] = numbers[left];
      tmp_pos = tmp_pos + 1;
      left = left +1;
    }
    else
    {
      temp[tmp_pos] = numbers[mid];
      tmp_pos = tmp_pos + 1;
      mid = mid + 1;
    }
  }
 
  while (left <= left_end)
  {
    temp[tmp_pos] = numbers[left];
    left = left + 1;
    tmp_pos = tmp_pos + 1;
  }
  while (mid <= right)
  {
    temp[tmp_pos] = numbers[mid];
    mid = mid + 1;
    tmp_pos = tmp_pos + 1;
  }
 
  for (i=0; i <= num_elements; i++)
  {
    numbers[right] = temp[right];
    right = right - 1;
  }
}
//--------------------------------------------------


void selectionsort(int *arr, int size)
{
 	int i,k,temp,smallest;
  	for(i=0;i<size-1;i++)
	{
		// Find the smallest element
		smallest = i;
		for(k = i + 1; k < size ; k++)
		{
			if(arr[smallest] > arr[k])
				smallest = k ;
		}
		if(i!=smallest)
		{
			temp=arr[i];
			arr[i]=arr[smallest];
			arr[smallest] = temp ;
		}
	}
}

void radixsort(int *arr, int size)
{
   
  int i, m = arr[0];
  int b[size], exp = 1;

  for (i = 0; i < size; i++)
  {
    if (arr[i] > m) {m = arr[i];}
  }
  
  int bucket[10] = {0,0,0,0,0,0,0,0,0,0};
  while (m/exp > 0)
  {
    for (i=0;i<size;i++){b[i]=0;}
    for (i=0;i<10;i++){bucket[i]=0;}
    for (i = 0; i < size; i++)
      {bucket[arr[i]/exp % 10]++;}
    for (i = 1; i < 10; i++)
      {bucket[i] += bucket[i - 1];}
    for (i = size - 1; i >= 0; i--)
    {
          b[bucket[arr[i]/exp%10]--] = arr[i];
          if(i==0){break;}
    }
    for (i = 0; i < size; i++){arr[i] = b[i];}
    exp = exp * 10;
  }
}

void bubblesort(int *arr, int size)
{
 for(int j=0; j<size; j++){
  for(int i=0; i<size-1; i++){
   if(arr[i+1] < arr[i])
    swap(arr[i+1], arr[i]);
  }
 }
}

void quickSort(int *arr, int size) 
{
  int  piv, beg[MAX_LEVELS], end[MAX_LEVELS], i=0, L, R, swap ;
  beg[0]=0; end[0]=size;
  while (i>=0) 
  {
    L=beg[i]; R=end[i]-1;
    if (L<R) 
    {
      piv=arr[L];
      while (L<R) 
      {
        while (arr[R]>=piv && L<R){ R--; }
        if (L<R){ arr[L++]=arr[R]; } 
        while (arr[L]<=piv && L<R) { L++; }
        if (L<R) { arr[R--]=arr[L]; }
      }
      arr[L]=piv; beg[i+1]=L+1; end[i+1]=end[i]; end[i++]=L;
      if (end[i]-beg[i]>end[i-1]-beg[i-1]) 
      {
        swap=beg[i]; beg[i]=beg[i-1]; beg[i-1]=swap;
        swap=end[i]; end[i]=end[i-1]; end[i-1]=swap;
      }
    }
    else { i--; }
  }
}
      
void shell(int *arr, int size)
{
  int i, j, increment, temp;

  increment = size / 2;
  while (increment > 0)
  {
    for (i=0; i < size; i++)
    {
      j = i;
      temp = arr[i];
      while ((j >= increment) && (arr[j-increment] > temp))
      {
        arr[j] = arr[j - increment];
        j = j - increment;
      }
      arr[j] = temp;
    }
    if (increment == 2)
    	increment = 1;
    else 
    	increment = increment * 5 / 11;
  }
}
     

int main()
{
    clock_t t;
    float result[5][2];
    int op = 1;
    int size = 1000;
    
    printf("which sort? 1-quick 2-bubble 3-selection 4-radix 5-merge 6-shell \n");
    scanf("%d",&op);
    
    
    for(int o = 0;o<5;o++)
    {
    int arr [size];
    int temp [size];
    switch (op)
    {
           case 1:
           {
           shuffle(arr,size);
           t = clock();quickSort(arr,size);t = clock() - t;
           break;}
           case 2:
           {
           shuffle(arr,size);
           t = clock();bubblesort(arr,size);t = clock() - t;
           break;}
           case 3:
           {
           shuffle(arr,size);
           t = clock();selectionsort(arr,size);t = clock() - t;
           break;}
           case 4:
           {
           shuffle(arr,size);
           t = clock();radixsort(arr,size);t = clock() - t;
           break;}
           case 5:
           {
           shuffle(arr,size);
           for(int i=0;i<size;i++){temp[i]=0;}
           t = clock();mergeSort(arr, temp, size);t = clock() - t;
           break;}
           case 6:
           {
           shuffle(arr,size);
           t = clock();shell(arr, size);t = clock() - t;
           break;}
           default:
           {
           t=0;printf("error 101: invalid option");
           break;}
    }
    
    result[o][0] = ((float)t)/CLOCKS_PER_SEC;
    result[o][1] = size;
    printf("time %f sec , size %f \n",result[o][0],result[o][1]);
    size = size +1000;
    }
    
    system("pause");
    return 0;
}


