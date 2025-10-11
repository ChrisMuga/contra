#include <stdio.h>


// TODO: Work on memory allocation using malloc or alloc
// TODO: Get positional arguments from command-line, on main
// 		- Use that to pass file path
int main(){
	FILE *file = fopen("./samples/1mb-examplefile-com.txt", "r");

	if (file == NULL){
		return printf("Error!\n");
	}

	// TODO: This will not suffice to read a large file like 
	// 		- ./samples/1mb-examplefile-com.txt
	// 		- What strategies can we use?
	char input[2048][3000];

	int i = 0;

	while(fgets(input[i], 3000, file)){
		printf("%d:\t%s", (i+1), input[i]);
		i = i+ 1;
	}

	fclose(file);
}
