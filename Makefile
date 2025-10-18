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
format:
	@ zig fmt ./
show-docs:
	@ zig build-lib -femit-docs src/main.zig
	@ python3 -m http.server 8000 -d docs/
deploy:
	@sudo echo "Building release build..."
	@zig build --release=small
	@cp zig-out/bin/contra ~/bin/
	@ echo "Copying binary \t\t ✅"
	@sudo ln -sf ~/bin/contra /usr/local/bin/contra
	@echo "Creating symlink \t ✅"
	@echo "Done \t\t\t ✅"
deploy-c:
	@sudo cp bin/contra ~/bin/
	@ echo "Copying binary \t\t ✅"
	@sudo ln -sf ~/bin/contra /usr/local/bin/contra
	@echo "Creating symlink \t ✅"
	@echo "Done \t\t\t ✅"
