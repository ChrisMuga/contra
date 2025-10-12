#include <stdio.h>
#include <stdlib.h>

// TODO: Work on memory allocation using malloc or alloc
// TODO: Get positional arguments from command-line, on main
// 		- Use that to pass file path
int main(){
	FILE *file = fopen("./samples/1mb-examplefile-com.txt", "r");
	// FILE *file = fopen("./samples/input.txt", "r");

	if (file == NULL){
		return printf("Error!\n");
	}

	// TODO: Explain line for line to understand what's going on here...
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
