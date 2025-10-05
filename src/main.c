#include <stdio.h>


// TODO: Work on memory allocation using malloc or alloc
// TODO: Investigate SegFault

int main(){
	FILE *file = fopen("input.txt", "r");

	if (file == NULL){
		return printf("Error!\n");
	}

	char input[2048][3000];

	int i = 0;

	while(fgets(input[i], 3000, file)){
		printf("%d:\t%s", (i+1), input[i]);
		i = i+ 1;
	}

	fclose(file);
}
