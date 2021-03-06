#include <stdlib.h>
#include <stdio.h>
#include "common.h"

float factorial(int n)
{
	int i;
	float res = 1;

	for (i = 2; i <= n; i++) {
		res *= i;
	}

	return res;
}


int main(int argc, char *argv[])
{
	int i, n;
	float coeff, fact;

	if (argc < 2) {
		fprintf(stderr, "Usage: %s n\n", argv[0]);
		exit(EXIT_FAILURE);
	}

	n = atoi(argv[1]);

	for (i = 0; i < n; i++) {
		fact = factorial(2 * i + 1);
		coeff = (i % 2 == 0) ? 1.0 / fact : -1.0 / fact;
		print_float_hex(stdout, coeff);
	}

	return 0;
}
