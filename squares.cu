//Program for squaring numbers in  an array on NVIOIA device
#include <stdio.h>
#include "book.h"

int  main (){
	
	int* array_host,* array_device;
	int N = 10;
	array_host = (int*)malloc(N*sizeof(int));
	cudaMalloc((void**)&array_device, N*sizeof(int));
	int i;
	for(i=0;i<N;i++)
	{
		array_host[i] = i;
		printf("array_host:%d \n ",array_host[i]);
	}
	int size = N;
	cudaMemcpy(array_device, array_host,size,cudaMemcpyHostToDevice);
	//block size and dimentions
	int blocksize = 4;
	int num_of_blocks = N/blocksize + (N%blocksize == 0 ? 0:1);
	//Kernell(deice call)

}

