//Program for squaring numbers in  an array on NVIOIA device
#include <stdio.h>
#include "book.h"
#include <math.h>
__global__ void square(int* a, int N)
{
	//calculate the unique thread index
	//blockIdx * blockDim + threadIdx
	int tId = blockIdx.x * blockDim.x + threadIdx.x;

	if(tId<N) a[tId] = a[tId] * a[tId];
}

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
	int size = N*sizeof(int);
	cudaMemcpy(array_device, array_host,size,cudaMemcpyHostToDevice);
	//block size and dimentions
	int blocksize = 4;
	int num_of_blocks = N/blocksize + (N%blocksize == 0 ? 0:1);
	int k;
        for (k = 0 ; k<N ; k++)
        {
                printf("The square of %d is %d \n",k, array_host[k]);;
        }
	//Kernell(deice call)
	square<<<num_of_blocks, blocksize>>>(array_device,N);
	//copy back the results from the device to host 
	cudaMemcpy(array_host,array_device,sizeof(int)*N, cudaMemcpyDeviceToHost);
	int j;
	for (j = 0 ; j<N ; j++)
	{
		printf("The square of %d is %d \n",j, array_host[j]);;
	}
	free(array_host);
	cudaFree(array_device);
}

