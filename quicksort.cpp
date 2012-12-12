#include <iostream>
#include <stdio.h>
#include <time.h>


//  quickSort
//
//  This public-domain C implementation by Darel Rex Finley.
//
//  * This function assumes it is called with valid parameters.
//
//  * Example calls:
//    quickSort(&myArray[0],5); // sorts elements 0, 1, 2, 3, and 4
//    quickSort(&myArray[3],5); // sorts elements 3, 4, 5, 6, and 7
# define arrnum  99999
# define  MAX_LEVELS  300

void quickSort(int *arr, int elements) 
{

 

  int  piv, beg[MAX_LEVELS], end[MAX_LEVELS], i=0, L, R, swap ;

  beg[0]=0; end[0]=elements;
  while (i>=0) {
    L=beg[i]; R=end[i]-1;
    if (L<R) {
      piv=arr[L];
      while (L<R) {
        while (arr[R]>=piv && L<R) R--; if (L<R) arr[L++]=arr[R];
        while (arr[L]<=piv && L<R) L++; if (L<R) arr[R--]=arr[L]; }
      arr[L]=piv; beg[i+1]=L+1; end[i+1]=end[i]; end[i++]=L;
      if (end[i]-beg[i]>end[i-1]-beg[i-1]) {
        swap=beg[i]; beg[i]=beg[i-1]; beg[i-1]=swap;
        swap=end[i]; end[i]=end[i-1]; end[i-1]=swap; }}
    else {
      i--; }}
}
      
int main()
{
    int arr [arrnum];
    int random = 0;
    clock_t t;
    srand ( time(NULL) );
    
    for (int k=0;k<arrnum;k++)
    {
        random = rand() % 99999 + 1;
        arr[k] = random;
    }
    t = clock();
    quickSort(arr,arrnum);
    t = clock() - t;
    
    printf ("\n It took me %d clicks (%f seconds).\n",t,((float)t)/CLOCKS_PER_SEC);
    
    system("pause");
    return 0;
}
