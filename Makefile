build-run:
	@ make build run -s
build:
	@ zig build
run:
	@ ./zig-out/bin/contra samples/input.txt
build-c:
	@ gcc -o bin/alt src/main.c
run-c:
	@ ./bin/alt
format:
	@ zig fmt ./
show-docs:
	@ zig build-lib -femit-docs src/main.zig
	@ python3 -m http.server 8000 -d docs/
