#include <stdio.h>

#include <cuda_runtime.h>

bool InitCuda()
{
	int count;
	cudaGetDeviceCount(&count);

	if (count == 0) {
		printf("There is no device.\n");
	}

	int i;
	for (i = 0; i < count; i++) {
		cudaDeviceProp prop;
		if (cudaGetDeviceProperties(&prop, i) == cudaSuccess) {
			if (prop.major >= 1) {
				break;
			}
		}
	}

	if (i == count) {
		printf("There is no device supporting CUDA 1.x.\n");
		return false;
	}

	cudaSetDevice(i);

	return true;
}

int main()
{
	if (InitCuda()) 
		printf("CUDA initialized.\n");

	int i = 0;
	int n = 5;
	for (i = 0; i < n; i++) {}

	printf("i = %d, n = %d\n", i, n);

	return 0;
}