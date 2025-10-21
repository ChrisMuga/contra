#include <stdio.h>
#include <stdlib.h>

#include "utils.h"

// NOTE: This C program can automatically pipe to nvim for example. Investigate
// 	- The zig program cannot do this out of the box

// TODO: Implement piping e.g. `git log | contra`
// TODO: Explain line for line to understand what's going on here...
// TODO: Show only line number, e.g `contra src/main.zig 14`
// TODO: Range of line numbers, e.g `contra src/main.zig 14-18`
// TODO: Script for debug and production/release builds
// TODO: contra --help
// TODO: contra --version
// TODO: Error handling in case:
//  - contra test.txt e (if line specifier A is invalid)
//  - contra test.txt 50:e (if line specifier B is invalid)
//  - contra test.txt 50-60 ("-" is an invalid delimiter)
//  - contra test.txt 50kk-60sk (either of the specifiers are not non-zero numbers)


// ## Examples:
//     - ./bin/contra example.txt // To print the whole file
//     - ./bin/contra example.txt 14 // To print line 14 only 
int main(int argc, char* argv[]){
	if(argc <= 1) {
		printf("Error: Please specify the input file\n");
		return 0;
	}

	char* range;
	int sln_a = -1;
	int sln_b = -1;

	char* filename = argv[1];

	if(argc > 1) {
		range = argv[2];
	}

	if(range != NULL) {
		int* x = split_range(range);

		sln_a = x[0];
		sln_b = x[1];
	}

	FILE *file = fopen(filename, "r");

	if (file == NULL){
		return printf("Error: Could not open file\n");
	}

	// Get file size
	fseek(file, 0L, SEEK_END);
	long size = ftell(file);

	if(sln_a == -1) {
		printf("File size: %ld\n", size);
	}

	char *buffer;

	buffer = (char *)malloc(size+1);

	fseek(file, 0L, SEEK_SET);

	int i = 1;

	if(sln_a < sln_b){
		printf("Printing L%d-L%d of %s\n", sln_a, sln_b, filename);
		echo("--------------------");
	}
	while(fgets(buffer, size+1, file)){
		if(sln_a == -1) {
			printf("%d: \t %s", i, buffer);
		}else if(sln_a < sln_b && i >= sln_a && i <= sln_b) {
			printf("%d: \t %s", i, buffer);
		}
		else if(sln_a == i){
			printf("========\n");
			printf("%d: %s", i, buffer);
			printf("========\n");
			break;
		}

		i = i+ 1;
	}
	if(sln_a < sln_b){
		echo("--------------------");
	}
	printf("\n");

	fclose(file);
}
