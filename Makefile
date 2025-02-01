run:
	@ ./zig-out/bin/contra
build-c:
	@ clang -o bin/alt src/main.c
	@ ./bin/alt
	
