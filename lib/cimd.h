#ifndef CIMD
# define CIMD 1
# include <stdint.h>

extern void my_add_values_sse2(uint8_t *src, uint8_t *src2);
#endif // !CIMD
