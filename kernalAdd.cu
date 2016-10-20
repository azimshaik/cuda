#include <iostream>
#include "book.h"
#include <stdio.h>
__global__ void add(int a, int b, int *c){
	int tid = blockIdx.x +threadIdx.x;
	*c = tid;
}

int main(void){
	int c;
	int *dev_c;
	cudaMalloc( (void**)&dev_c, sizeof(int) );
	
	add<<<1,10>>>(2,7,dev_c) ;
	HANDLE_ERROR(  cudaMemcpy( &c, dev_c, sizeof(int), cudaMemcpyDeviceToHost));
	printf("2+7= %d\n",c);
	cudaFree(dev_c);
	return 0; 
}
