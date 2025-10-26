build-run:
	@ make build run -s
build:
	@ zig build
run:
	@ ./zig-out/bin/contra samples/input.txt
build-c:
	@ gcc -o bin/contra src/main.c
run-c:
	@ ./bin/contra samples/input.txt
build-odin:
	@ mkdir -p bin/odin
	@ odin build ./src -out:bin/odin/contra
run-odin:
	@ ./bin/odin/contra samples/input.txt:20
# Dry run C build
dry-c:
	@ make build-c -s
	@ ./bin/contra samples/input.txt 37:38
format:
	@ echo "Formatting all .zig files..."
	@ zig fmt ./
format-c:
	@ echo "Formatting C files in src/.."
	@ clang-format ./src/*.c -i --verbose
	@ clang-format ./src/*.h -i --verbose
	@ echo "Done"
format-all:
	@ make format format-c -s;
clean:
	@ echo "Clearing caches"
	@ rm -rf ~/.cache/zig .zig-cache zig-out
	@ echo "Done ✅"
show-docs:
	@ zig build-lib -femit-docs src/main.zig
	@ python3 -m http.server 8000 -d docs/
deploy:
	@ sudo echo "Building release build..."
	@ zig build --release=small
	@ sudo cp zig-out/bin/contra ~/bin/
	@ echo "Copying binary \t\t ✅"
	@ sudo ln -sf ~/bin/contra /usr/local/bin/contra
	@ echo "Creating symlink \t ✅"
	@ echo "Done \t\t\t ✅"
deploy-c:
	@ sudo echo "Building release build..."
	@ make build-c -s
	@ sudo cp bin/contra ~/bin/
	@ echo "Copying binary \t\t ✅"
	@ sudo ln -sf ~/bin/contra /usr/local/bin/contra
	@ echo "Creating symlink \t ✅"
	@ echo "Done \t\t\t ✅"
