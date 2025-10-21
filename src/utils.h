#include <stdio.h>
#include <stdlib.h>
#include <string.h>

void echo(char val[]){
	printf("%s\n", val);
}

// TODO: Documentation
int* split_range(char range[]) {
	// TODO; Is there a way to know the length of char[] without string.h?
	static int x[2];

	static char buffer[] = "";

	int c = 0;

	for(int i = 0; i < strlen(range); i++) {
		if(range[i] == ':'){
			x[0] = atoi(buffer);
			c = 0;
			continue;
		}else{
			buffer[c] = range[i];
			c++;
		}
	}

	x[1] = atoi(buffer);

	return x;
}
