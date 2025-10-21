#include <stdio.h>
#include <stdlib.h>
#include <string.h>

void echo(char val[]){
	printf("%s\n", val);
}

// TODO: Documentation
char** split(char* string, char delimiter) {
	char** res = (char**)malloc(strlen(string)+1);
	char* buffer = (char*)malloc(strlen(string)+1);
	int b = 0;
	int count = 0;

	for(int i =0; i < strlen(string); i++){
		if(string[i] == delimiter) {
			res[count] = buffer;
			buffer = (char*)malloc(strlen(string));		
			b = 0;
			count++;
			continue;
		}else{
			buffer[b] = string[i];
			b++;
		}
	}

	if(strlen(buffer) > 0){
		res[count] = buffer;
		buffer = (char*)malloc(strlen(string));
	}
	return res;
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

int has_char(char haystack[], char needle){
	for(int i= 0; i < strlen(haystack); i++){
		if(haystack[i] == needle){
			return 1;
		}
	}

	return 0;
}
