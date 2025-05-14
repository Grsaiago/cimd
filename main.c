#include "lib/cimd.h"
#include <stdio.h>

int main(void) {
	uint8_t	src[] = {1, 2, 3, 4, 5, 6, 7, 8};
	uint8_t	src1[] = {1, 2, 3, 4, 5, 6, 7, 8};

	my_add_values_sse2(src, src1);

	for (int i = 0; i < 8; i++) {
		printf("src[%d]: %d\n", i, src[i]);
	}
}
