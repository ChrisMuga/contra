package odin

import "core:fmt"
import "core:strings"
import "core:os";
import "core:strconv";

is_flag :: proc(s: string) -> bool {
	return strings.contains(s, "--")
}

handle_flag :: proc(flag: string) {
	switch flag {
		case FLAG_VERSION:
			fmt.println("contra v0.0.1")
		case FLAG_HELP:
			help()
	}
}

read_file :: proc(path: string, line_a: int = -1) {
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
				if line_a > 0 {
					if line_a == line_number {
						fmt.printf("%d\t", line_number)
					}
				} else {
					fmt.printf("%d\t", line_number)
				}
			}

			if line_a > 0 {
				if line_a == line_number {
					fmt.printf("%c", buff[i])
				}
			} else {
				fmt.printf("%c", buff[i])
			}

			i += 1
		}

		delete(buff)
	} else {
		fmt.println("Error: Cannot open file", err)
	}
}

help :: proc() {
	handle_flag(FLAG_VERSION)
	fmt.println("Built with Odin - https://github.com/odin-lang/Odin")
	// TODO: Fix this
	fmt.println(
	`
contra [file | args]
---------
args
---------

--help			show help
--version		show version
	`)
}
