package contra

import "core:fmt"
import "core:strings"
import "core:os";
import "core:strconv";

import "utils:common"
import "utils:file"

main :: proc() {
	i: int = 0
	j: int  = len(os.args)

	if j == 1 {
		common.help()
	} else if j == 2 {
		input: string = os.args[1]

		if common.is_flag(input) {
			common.handle_flag(input)
		} else {
			split_args: []string = strings.split(input, ":")

			if len(split_args) == 0 {
				fmt.println("No file specified")
			} else if(len(split_args) == 1) {
				file.read_file(input)
			} else {
				file_name: string = split_args[0]

				if len(split_args) == 2 {
					line_a, ok_a := strconv.parse_int(split_args[1])
					if ok_a {
						file.read_file(file_name, line_a)
					}
				} else if len(split_args) > 2 {
					line_a, ok_a := strconv.parse_int(split_args[1])
					line_b, ok_b := strconv.parse_int(split_args[2])

					if ok_a && ok_b {
						file.read_file(file_name, line_a, line_b)
					}
				} 
			}
		}
	}
}
