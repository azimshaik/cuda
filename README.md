# cuda
NVIDIA Block and thread communication

Kernel call 
add<<<5,100>>>  indicates blockDim.x is 100 and its threadIdx.x could be <5

Declaring functions
__global__     	declares kernel, which is called on host and executed on device
__device__     	declares device function, which is called and executed on device
__host__       	declares host function, which is called and executed on host
__noinline__   	to avoid inlining
__forceinline__	to force inlining

dim3 can take 1, 2, or 3 argumetns:
dim3 blocks1D( 5       );
dim3 blocks2D( 5, 5    );
dim3 blocks3D( 5, 5, 5 );

Kernel invocation
__global__ void kernel( ... ) { ... }

dim3 blocks( nx, ny, nz );           // cuda 1.x has 1D and 2D grids, cuda 2.x adds 3D grids
dim3 threadsPerBlock( mx, my, mz );  // cuda 1.x has 1D, 2D, and 3D blocks

kernel<<< blocks, threadsPerBlock >>>( ... );

Pre-defined variables
dim3  gridDim  	dimensions of grid
dim3  blockDim 	dimensions of block
uint3 blockIdx 	block index within grid
uint3 threadIdx	thread index within block
int   warpSize 	number of threads in warp

Thread management
__threadfence_block(); 	wait until memory accesses are visible to block
__threadfence();       	wait until memory accesses are visible to block and device
__threadfence_system();	wait until memory accesses are visible to block and device and host (2.x)
__syncthreads();       	wait until all threads reach sync

Timer
wall clock cycle counter
clock_t clock();


