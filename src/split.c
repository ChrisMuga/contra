#include <string.h>   
#include <stdlib.h>
#include <stdio.h>

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
		printf("---> %s\n", buffer);
		printf("---* %s\n", res[0]);
		res[count] = buffer;
		buffer = (char*)malloc(strlen(string));
	}
	return res;
}

int main(){
	char** x = split("src/test:30", ':');
	printf("%s--%s", x[0], x[1]);
}
