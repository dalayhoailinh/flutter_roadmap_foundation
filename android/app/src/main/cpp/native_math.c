#include <stdint.h>

int64_t fast_sum(const int64_t* prices, int32_t count) {
    int64_t total = 0;
    for (int32_t i = 0; i < count; ++i) {
        total += prices[i];
    }
    return total;
}