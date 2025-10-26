package main

import "core:fmt"
import "core:strings"
import "core:os";

// Odin language ref: 
// - https://odin-lang.org/docs/overview/

FLAG_VERSION : string : "--version"

main :: proc() {
	// TODO: Implement file read
	// - https://pkg.odin-lang.org/core/os/#open
	// - https://pkg.odin-lang.org/core/os/#read

	i: int = 0
	j: int  = len(os.args)

	if j == 2 {
		input: string = os.args[1]

		if is_flag(input) {
			handle_flag(input)
		} else {
			read_file(input)
		}
	}
}

is_flag :: proc(s: string) -> bool {
	return strings.contains(s, "--")
}

handle_flag :: proc(flag: string) {
	switch flag {
		case FLAG_VERSION:
			fmt.println("contra v0.0.1")
	}
}

// TODO: Implement line numbers
read_file :: proc(path: string) {
	handle, err := os.open(path)

	if err == nil {
		i:i64 = 0
		
		file_size, y := os.file_size(handle)

		buff := make([dynamic]u8, file_size)

		for {
			total_read, err := os.read(handle, buff[:])

			if i >= file_size {
				fmt.printf("\n")

				break;
			}

			fmt.printf("%c", buff[i])

			i += 1
		}

		delete(buff)
	}else {
		fmt.println("Error--->", err)
	}

}
