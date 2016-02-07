/******************************************************************************
 *cr
 *cr            (C) Copyright 2010 The Board of Trustees of the
 *cr                        University of Illinois
 *cr                         All Rights Reserved
 *cr
 ******************************************************************************/

#include <stdio.h>
#include <time.h>
#include "support.h"
#include "kernel.cu"

int main(int argc, char**argv) {

    Timer timer;
    cudaError_t cuda_ret;
    time_t t;


    // Initialize host variables ----------------------------------------------

    printf("\nSetting up the problem..."); fflush(stdout);
    startTime(&timer);

    unsigned int n;
    if(argc == 1) {
        n = 10000;
    } else if(argc == 2) {
        n = atoi(argv[1]);
    } else {
        printf("\n    Invalid input parameters!"
           "\n    Usage: ./vecadd               # Vector of size 10,000 is used"
           "\n    Usage: ./vecadd <m>           # Vector of size m is used"
           "\n");
        exit(0);
    }

    /* Intializes random number generator */
    srand((unsigned) time(&t));    
    
    
    float* A_h = (float*) malloc( sizeof(float)*n );
    float* B_h = (float*) malloc( sizeof(float)*n );
    float* C_h = (float*) malloc( sizeof(float)*n );

	// check if the vectors were properly allocated on host
	if (A_h == 0 || B_h == 0 || C_h == 0)
	{
		printf("could not allocate vectors on host.\n");
		exit(EXIT_FAILURE);
	}


    for (unsigned int i=0; i < n; i++) { A_h[i] = (rand()%100)/100.00; }
    for (unsigned int i=0; i < n; i++) { B_h[i] = (rand()%100)/100.00; }


    stopTime(&timer); printf("%f s\n", elapsedTime(timer));
    printf("    Vector size = %u\n", n);

    // Allocate device variables ----------------------------------------------

    printf("Allocating device variables..."); fflush(stdout);
    startTime(&timer);

    //INSERT CODE HERE
	float *A_d, *B_d, *C_d;
	
	if (cudaMalloc((void**)&A_d, sizeof(float)*n) != cudaSuccess)
	{
		printf("%s\n", cudaGetErrorString(cuda_ret));
		exit(EXIT_FAILURE);
	}

	if (cudaMalloc((void**)&B_d, sizeof(float)*n) != cudaSuccess)
	{
		printf("%s\n", cudaGetErrorString(cuda_ret));
		exit(EXIT_FAILURE);
	}

	if (cudaMalloc((void**)&C_d, sizeof(float)*n) != cudaSuccess)
	{
		printf("%s\n", cudaGetErrorString(cuda_ret));
		exit(EXIT_FAILURE);
	}

    cudaDeviceSynchronize();
    stopTime(&timer); printf("%f s\n", elapsedTime(timer));

    // Copy host variables to device ------------------------------------------

    printf("Copying data from host to device..."); fflush(stdout);
    startTime(&timer);

    //INSERT CODE HERE






    cudaDeviceSynchronize();
    stopTime(&timer); printf("%f s\n", elapsedTime(timer));

    // Launch kernel ----------------------------------------------------------

    printf("Launching kernel..."); fflush(stdout);
    startTime(&timer);

    //INSERT CODE HERE





    cuda_ret = cudaDeviceSynchronize();
	if(cuda_ret != cudaSuccess) FATAL("Unable to launch kernel");
    stopTime(&timer); printf("%f s\n", elapsedTime(timer));

    // Copy device variables from host ----------------------------------------

    printf("Copying data from device to host..."); fflush(stdout);
    startTime(&timer);

    //INSERT CODE HERE



    cudaDeviceSynchronize();
    stopTime(&timer); printf("%f s\n", elapsedTime(timer));

    // Verify correctness -----------------------------------------------------

    printf("Verifying results..."); fflush(stdout);

    verify(A_h, B_h, C_h, n);

    // Free memory ------------------------------------------------------------

    free(A_h);
    free(B_h);
    free(C_h);

    //INSERT CODE HERE




    return 0;

}
