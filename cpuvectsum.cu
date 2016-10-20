#include "book.h"
#include <stdio.h>
#define N 10

void add(int* a, int* b, int* c)
{
	printf("\n The add function is called");
	for (int k=0; k<N; k++)
	{
		c[k] = a[k]+ b[k];
	}
	for (int k=0; k<N; k++)
	{
		printf("%d \n", c[k]);
	}
}
int main()
{
	int a[N], b[N], c[N];

	for (int i=0; i<N; i++){
		a[i] = -i;
		b[i] = i*i;
	}
	for (int j=0; j<N; j++)
	{
		printf("%d %d \n",a[j], b[j]);
	}
	add(a,b,c);
}
