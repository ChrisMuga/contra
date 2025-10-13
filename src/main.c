#include <stdio.h>
#include <stdlib.h>

// TODO: Explain line for line to understand what's going on here...
int main(int argc, char* argv[]){
	if(argc <= 1) {
		printf("Error: Please specify the input file\n");
		return 0;
	}

	char* filename = argv[1];

	FILE *file = fopen(filename, "r");

	if (file == NULL){
		return printf("Error: Could not open file\n");
	}

	// Get file size
	fseek(file, 0L, SEEK_END);
	long size = ftell(file);
	printf("File size: %ld\n", size);

	char *buffer;

	buffer = (char *)malloc(size+1);

	fseek(file, 0L, SEEK_SET);

	int i = 1;
	while(fgets(buffer, size+1, file)){
		printf("%d: \t %s", i, buffer);
		i = i+ 1;
	}

	fclose(file);
}
