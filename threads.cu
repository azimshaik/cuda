#include <iostream>
#include "book.h"
#include <stdio.h>
__global__ void add(int a, int b, int *c, int *d){
	int bid = blockIdx.x;
	int tid = blockDim.x;
	*c = bid;
	*d = tid;
}

int main(void){
	int c,d;
	int *dev_c, *dev_d;
	cudaMalloc( (void**)&dev_c, sizeof(int) );
	cudaMalloc( (void**)&dev_d, sizeof(int) );	
	add<<<5,100>>>(2,7,dev_c, dev_d) ;
	cudaMemcpy( &c, dev_c, sizeof(int), cudaMemcpyDeviceToHost);
	cudaMemcpy( &d, dev_d, sizeof(int), cudaMemcpyDeviceToHost);
	printf("this is blockIdx.x : %d\n",c);
	printf("this is blockDim.x:  %d\n",d);
	cudaFree(dev_c);
	cudaFree(dev_d);
	return 0; 
}
