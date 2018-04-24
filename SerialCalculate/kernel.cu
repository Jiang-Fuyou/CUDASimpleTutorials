#include <stdio.h>
#include <stdlib.h>
#include <math.h>

#include <cuda_runtime.h>

__global__ void SOS(int *result, int *input, const int num)
{
	int sum = 0;
	for (int i = 0; i < num; i++) {
		sum += input[i] * input[i];
	}
	
	*result = sum;
}

int main()
{
	const int n = 5;
	int h_a[n] = { 1, 2, 3, 4, 5 };
	int h_r;

	int *d_a, *d_r;
	cudaMalloc((void **)&d_a, n * sizeof(int));
	cudaMalloc((void **)&d_r, 1 * sizeof(int));

	cudaMemcpy(d_a, h_a, n * sizeof(int), cudaMemcpyHostToDevice);

	SOS<<<1, 1>>>(d_r, d_a, n);

	cudaMemcpy(&h_r, d_r, 1 * sizeof(int), cudaMemcpyDeviceToHost);

	cudaFree(d_a);
	cudaFree(d_r);

	printf("Result: %d\n", h_r);
}