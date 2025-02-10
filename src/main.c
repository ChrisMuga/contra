#include <stdio.h>

int main(){
	FILE *file = fopen("input.txt", "r");

	if (file == NULL){
		return printf("Error!\n");
	}

	char input[10][3000];

	int c = 0;

	while(fgets(input[c], 3000, file)){
		printf("%d -> %s", (c+1), input[c]);
		c = c+ 1;
	}

	fclose(file);

	int d = 0;

	while(d < c){
		printf("%s--->\n", input[d]);
		d = d + 1;
	}
}
