package main

import "core:fmt"
import "core:strings"
import "core:os";
import "core:strconv";

// Odin language ref: 
// - https://odin-lang.org/docs/overview/

FLAG_VERSION : string : "--version"

main :: proc() {
	// - https://pkg.odin-lang.org/core/os/#open
	// - https://pkg.odin-lang.org/core/os/#read

	i: int = 0
	j: int  = len(os.args)

	if j == 2 {
		input: string = os.args[1]

		if is_flag(input) {
			handle_flag(input)
		} else {
			split_args: []string = strings.split(input, ":")

			if len(split_args) == 0 {
				fmt.println("No file specified")
			} else if(len(split_args) == 1){
				read_file(input)
			} else {
				line_number, ok := strconv.parse_int(split_args[1])
				read_file(split_args[0], line_number)
			}
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

read_file :: proc(path: string, specified_line_number: int = -1) {
	handle, err := os.open(path)

	if err == nil {
		i:i64 = 0
		
		file_size, y := os.file_size(handle)

		buff := make([dynamic]u8, file_size)

		line_number:int = 0

		for {
			total_read, err := os.read(handle, buff[:])

			if i >= file_size {
				fmt.printf("\n")

				break;
			}

			if i == 0 || buff[i-1] == '\n' {
				line_number += 1
				if specified_line_number > 0 {
					if specified_line_number == line_number {
						fmt.printf("%d\t", line_number)
					}
				} else {
					fmt.printf("%d\t", line_number)
				}
			}

			if specified_line_number > 0 {
				if specified_line_number == line_number {
					fmt.printf("%c", buff[i])
				}
			} else {
				fmt.printf("%c", buff[i])
			}

			i += 1
		}

		delete(buff)
	}else {
		fmt.println("Error: Cannot open file", err)
	}

}
