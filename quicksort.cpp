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
      
      

int main()
{
    clock_t t;
    float result[5][2];
    int op = 1;
    int size = 1000;
    
    printf("which sort? 1-quick 2-bubble 3-selection 4-radix \n");
    scanf("%d",&op);
    
    
    for(int o = 0;o<5;o++)
    {
    int arr [size];
    
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


