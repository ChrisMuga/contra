package file

import "core:os";
import "core:fmt"
import "core:sys/posix"

read_file :: proc(path: string, line_a: int = -1, line_b: int = -1) {
	handle, err := os.open(path)

	if err != nil {
		fmt.printf("Error: %s (%s)\n", os.error_string(err), path)
		return
	}

	if os.is_dir(path) {
		fi, err := os.read_dir(handle, 0)

		if err != nil {
			fmt.println("Error introspecting dir:", err)
			return
		}

		fmt.println(path, "is a directory containing:")
		if len(fi) > 0 {
			fmt.println("-----------")	
		}
		for f in fi {
			ft := f.is_dir ? "folder" : "file"
			fmt.printf("> %s (%s)\n\t- %d bytes\n", f.name, ft, f.size)
		}

		if len(fi) > 0 {
			fmt.println("-----------")	
		}
		return
	}

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
}
