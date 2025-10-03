build-run:
	@ zig build
	@ ./zig-out/bin/contra
run:
	@ ./zig-out/bin/contra
build-c:
	@ gcc -o bin/alt src/main.c
run-c:
	@ make build-c
	@ ./bin/alt
	
