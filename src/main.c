#include <stdio.h>
#include <stdlib.h>

// TODO: Implement piping e.g. `git log | contra`
// TODO: Explain line for line to understand what's going on here...
/// TODO: Show only line number, e.g `contra src/main.zig 14`
/// TODO: Range of line numbers, e.g `contra src/main.zig 14-18`
int main(int argc, char* argv[]){
	if(argc <= 1) {
		printf("Error: Please specify the input file\n");
		return 0;
	}

	char* number;
	int line_number = -1;

	char* filename = argv[1];

	if(argc > 1) {
		number = argv[2];
	}

	if(number != NULL) {
		line_number = atoi(number);
	}

	FILE *file = fopen(filename, "r");

	if (file == NULL){
		return printf("Error: Could not open file\n");
	}

	// Get file size
	fseek(file, 0L, SEEK_END);
	long size = ftell(file);

	if(line_number == -1) {
		printf("File size: %ld\n", size);
	}

	char *buffer;

	buffer = (char *)malloc(size+1);

	fseek(file, 0L, SEEK_SET);

	int i = 1;

	while(fgets(buffer, size+1, file)){
		if(line_number == -1) {
			printf("%d: \t %s", i, buffer);
		}else if(line_number == i){
			printf("%d: \t %s", i, buffer);
			break;
		}

		i = i+ 1;
	}

	fclose(file);
}
