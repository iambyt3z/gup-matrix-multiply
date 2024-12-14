#include <stdint.h>
#include <stdlib.h>
#include <stdio.h>
#include <chrono>

#include "support.h"

void verify
(float *A, float *B, float *C, unsigned int m, unsigned int k,unsigned int n) 
{
    const float relativeTolerance = 1e-6;
    unsigned int count = 0;

    for (unsigned int row = 0; row < m; ++row) {
        for (unsigned int col = 0; col < n; ++col) {
            float sum = 0;
            for (unsigned int i = 0; i < k; ++i) {
                sum += A[row * k + i] * B[i * n + col];
            }
            count++;
            float relativeError = (sum - C[row * n + col]) / sum;
            // Uncomment for debugging:
            // printf("%f/%f ", sum, C[row*n + col]);
            if (relativeError > relativeTolerance || relativeError < -relativeTolerance) {
                printf("\nTEST FAILED %u\n\n", count);
                exit(1);
            }
        }
    }
    printf("TEST PASSED %u\n\n", count);
}

void 
startTime(Timer* timer) 
{
    if (timer) {
        timer->startTime = std::chrono::high_resolution_clock::now();
    }
}

void 
stopTime(Timer* timer) 
{
    if (timer) {
        timer->endTime = std::chrono::high_resolution_clock::now();
    }
}

float 
elapsedTime(Timer timer) 
{
    auto duration = std::chrono::duration_cast<std::chrono::microseconds>(
        timer.endTime - timer.startTime);
    return duration.count() / 1000.0f; // Convert microseconds to milliseconds
}
