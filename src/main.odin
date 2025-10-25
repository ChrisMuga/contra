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
		flag: string = os.args[1]

		if is_flag(flag) {
			handle_flag(flag)
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
