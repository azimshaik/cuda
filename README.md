# cuda
NVIDIA Block and thread communication

Kernel call 
add<<<5,100>>>  indicates blockDim.x is 100 and its threadIdx.x could be <5

Declaring functions


__global__    	declares kernel, which is called on host and executed on device

__device__     	declares device function, which is called and executed on device

__host__           	declares host function, which is called and executed on host

__noinline__     	to avoid inlining

__forceinline__	       to force inlining
