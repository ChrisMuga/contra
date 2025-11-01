package file

import "core:os";
import "core:fmt"

// TODO: Show prompt depending on range situation
read_file :: proc(path: string, line_a: int = -1, line_b: int = -1) {
	handle, err := os.open(path)

	if err == nil {
		i:i64 = 0
		
		file_size, y := os.file_size(handle)

		buff := make([dynamic]u8, file_size)

		line_number:int = 0

		if line_a == -1 && line_a == -1 {
			fmt.println("--------------")
			fmt.printf("Reading %s\n", path)
			fmt.println("--------------")
		} else if line_a > 0 && line_b == -1 {
			fmt.println("--------------")
			fmt.printf("Reading line %d of %s\n", line_a, path)
			fmt.println("--------------")
		} else if line_a > 0 && line_b > 0 {
			fmt.println("--------------")
			fmt.printf("Reading line %d-%d of %s\n", line_a, line_b, path)
			fmt.println("--------------")
		}

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
					} else if line_b > line_a && (line_number >= line_a && line_number <= line_b) {
						fmt.printf("%d\t", line_number)
					}
				} else {
					fmt.printf("%d\t", line_number)
				}
			}

			if line_a > 0 {
				if line_a == line_number {
					fmt.printf("%c", buff[i])
				} else if line_b > line_a && (line_number >= line_a && line_number <= line_b) {
					fmt.printf("%c", buff[i])
				}
			} else {
				fmt.printf("%c", buff[i])
			}

			i += 1
		}

		delete(buff)
	} else {
		fmt.println("Error: Cannot open file ->", err)
	}
}
