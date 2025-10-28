package contra

import "core:fmt"
import "core:strings"
import "core:os";
import "core:strconv";

// import "

// Odin language ref: 
// - https://odin-lang.org/docs/overview/

FLAG_VERSION : string : "--version"
FLAG_HELP: string : "--help"

main :: proc() {
	// - https://pkg.odin-lang.org/core/os/#open
	// - https://pkg.odin-lang.org/core/os/#read

	i: int = 0
	j: int  = len(os.args)

	if j == 1 {
		help()
	} else if j == 2 {
		input: string = os.args[1]

		if is_flag(input) {
			handle_flag(input)
		} else {
			split_args: []string = strings.split(input, ":")

			if len(split_args) == 0 {
				fmt.println("No file specified")
			} else if(len(split_args) == 1) {
				read_file(input)
			} else {
				line_number, ok := strconv.parse_int(split_args[1])
				read_file(split_args[0], line_number)
			}
		}
	}
}
