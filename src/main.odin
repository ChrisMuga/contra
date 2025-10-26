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

read_file :: proc(path: string) {
	fmt.println(path);
	handle, err := os.open(path)

	if err == nil {
		fmt.println(handle)

		i:int = 0;
		
		// x, y := os.file_size(path)
		buff: [2156]u8
		for {
			total_read, err := os.read(handle, buff[:])
			if i == total_read-1 {
				break;
			}

			fmt.printf("%c", buff[i])
			i += 1
		}
	}else {
		fmt.println("Error--->", err)
	}

}
