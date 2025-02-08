run:
	@ ./zig-out/bin/contra
build-c:
	@ gcc -o bin/alt src/main.c
	@ ./bin/alt
	
