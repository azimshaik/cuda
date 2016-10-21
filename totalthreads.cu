#include <iostream>
#include "book.h"
#include <stdio.h>
__global__ void add(int a, int b, int *c, int *d, int *e, int *f){
	int blocksPerGrid   = gridDim.x;
	int threadsPerBlock = blockDim.x;
	int totalThreadNum  = gridDim.x * blockDim.x;;
	int curThreadIdx    = (blockIdx.x * blockDim.x) + threadIdx.x;
	*c = blocksPerGrid;
	*d = threadsPerBlock;
	*e = totalThreadNum;
	*f = curThreadIdx;
}

int main(void){
	int c,d,e,f;
	int *dev_c, *dev_d, *dev_e, *dev_f;
	cudaMalloc( (void**)&dev_c, sizeof(int) );
	cudaMalloc( (void**)&dev_d, sizeof(int) );
	cudaMalloc( (void**)&dev_e, sizeof(int) );
	cudaMalloc( (void**)&dev_f, sizeof(int) );	
	add<<<5,100>>>(2,7,dev_c, dev_d, dev_e, dev_f) ;
	cudaMemcpy( &c, dev_c, sizeof(int), cudaMemcpyDeviceToHost);
	cudaMemcpy( &d, dev_d, sizeof(int), cudaMemcpyDeviceToHost);
	cudaMemcpy( &e, dev_e, sizeof(int), cudaMemcpyDeviceToHost);
	cudaMemcpy( &f, dev_f, sizeof(int), cudaMemcpyDeviceToHost);
	printf("blocks Per Grid : %d\n",c);
	printf("threads per block:  %d\n",d);
	printf("total number of threads:  %d\n",e);
	printf("Current Thread  Index:  %d\n",f);
	cudaFree(dev_c);
	cudaFree(dev_d);
	cudaFree(dev_e);
	cudaFree(dev_f);
	return 0; 
}
