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

dimy gement
__device__ float* pointer;
cudaMalloc( (void**) &pointer, size );
cudaFree( pointer );

__constant__ float dev_data[n];
float host_data[n];
cudaMemcpyToSymbol  ( dev_data,  host_data, sizeof(host_data) );  // dev_data  = host_data
cudaMemcpyFromSymbol( host_data, dev_data,  sizeof(host_data) );  // host_data = dev_data

// direction is one of cudaMemcpyHostToDevice or cudaMemcpyDeviceToHost
cudaMemcpy     ( dst_pointer, src_pointer, size, direction );
cudaMemcpyAsync( dst_pointer, src_pointer, size, direction, stream );

// using column-wise notation
// (the CUDA docs describe it for images; a “row” there equals a matrix column)
// _bytes indicates arguments that must be specified in bytes
cudaMemcpy2D     ( A_dst, lda_bytes, B_src, ldb_bytes, m_bytes, n, direction );
cudaMemcpy2DAsync( A_dst, lda_bytes, B_src, ldb_bytes, m_bytes, n, direction, stream );

// cublas makes copies easier for matrices, e.g., less use of sizeof
// copy x => y
cublasSetVector     ( n, elemSize, x_src_host, incx, y_dst_dev,  incy );
cublasGetVector     ( n, elemSize, x_src_dev,  incx, y_dst_host, incy );
cublasSetVectorAsync( n, elemSize, x_src_host, incx, y_dst_dev,  incy, stream );
cublasGetVectorAsync( n, elemSize, x_src_dev,  incx, y_dst_host, incy, stream );

// copy A => B
cublasSetMatrix     ( rows, cols, elemSize, A_src_host, lda, B_dst_dev,  ldb );
cublasGetMatrix     ( rows, cols, elemSize, A_src_dev,  lda, B_dst_host, ldb );
cublasSetMatrixAsync( rows, cols, elemSize, A_src_host, lda, B_dst_dev,  ldb, stream );
cublasGetMatrixAsync( rows, cols, elemSize, A_src_dev,  lda, B_dst_host, ldb, stream );
Also, malloc and free work inside a kernel (2.x), but memory allocated in a kernel must be deallocated in a kernel (not the host). It can be freed in a different kernel, though.blocks( nx, ny, nz );           // cuda 1.x has 1D and 2D grids, cuda 2.x adds 3D grids
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


