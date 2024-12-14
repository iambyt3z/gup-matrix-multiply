#ifndef __FILEH__
#define __FILEH__

#include <chrono>
#include <cstdio>
#include <cstdlib>

typedef struct {
    std::chrono::time_point<std::chrono::high_resolution_clock> startTime;
    std::chrono::time_point<std::chrono::high_resolution_clock> endTime;
} Timer;

#ifdef __cplusplus
extern "C" {
#endif

void verify(float *A, float *B, float *C, unsigned int m, unsigned int k, unsigned int n);

void startTime(Timer* timer);
void stopTime(Timer* timer);
float elapsedTime(Timer timer);

#ifdef __cplusplus
}
#endif

#define FATAL(msg, ...) \
    do { \
        fprintf(stderr, "[%s:%d] " msg "\n", __FILE__, __LINE__, ##__VA_ARGS__); \
        exit(-1); \
    } while (0)

#if defined(__BYTE_ORDER__) && (__BYTE_ORDER__ != __ORDER_LITTLE_ENDIAN__)
# error "File I/O is not implemented for this system: wrong endianness."
#endif

#endif
