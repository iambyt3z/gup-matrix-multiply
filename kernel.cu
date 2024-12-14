#include <stdio.h>

#define TILE_SIZE 16

__global__ void
mysgemm(int m, int n, int k, const float *A, const float *B, float* C)
{
    // Allocate shared memory for sub-matrices of A and B
    __shared__ float A_shared[TILE_SIZE][TILE_SIZE];
    __shared__ float B_shared[TILE_SIZE][TILE_SIZE];

    // Calculate the row and column index of the element C
    int row = blockIdx.y * TILE_SIZE + threadIdx.y;
    int col = blockIdx.x * TILE_SIZE + threadIdx.x;
    
    float C_value = 0;

    // Loop over tiles of A and B
    for (int tile = 0; tile < (k + TILE_SIZE - 1) / TILE_SIZE; tile++) {
        // Load tiles into shared memory
        A_shared[threadIdx.y][threadIdx.x] = 
            (float) (row < m && tile * TILE_SIZE + threadIdx.x < k) *
            A[row * k + tile * TILE_SIZE + threadIdx.x];
        
        B_shared[threadIdx.y][threadIdx.x] = 
            (float) (col < n && tile * TILE_SIZE + threadIdx.y < k) *
            B[(tile * TILE_SIZE + threadIdx.y) * n + col];

        __syncthreads();

        // Multiply the two matrices
        for (int kk = 0; kk < TILE_SIZE; kk++) {
            C_value += A_shared[threadIdx.y][kk] * B_shared[kk][threadIdx.x];
        }

        __syncthreads();
    }

    // Write result to C
    if (row < m && col < n) {
        C[row * n + col] = C_value;
    }
}

void 
basicSgemm(int m, int n, int k, const float *A, const float *B, float *C) 
{
    const unsigned int BLOCK_SIZE = TILE_SIZE;

    dim3 dim_block(BLOCK_SIZE, BLOCK_SIZE);
    dim3 dim_grid((n + BLOCK_SIZE - 1) / BLOCK_SIZE, (m + BLOCK_SIZE - 1) / BLOCK_SIZE);

    // Launch the tiled matrix multiplication kernel
    mysgemm<<<dim_grid, dim_block>>>(m, n, k, A, B, C);
}
