build-run:
	make build run
build:
	@ zig build
run:
	@ ./zig-out/bin/contra
build-c:
	@ gcc -o bin/alt src/main.c
build-run-c:
	@ make build-c
	@ ./bin/alt
run-c:
	@ ./bin/alt
format:
	@ zig fmt ./
