package common

import "core:fmt"
import "core:strings"
import "core:strconv";

FLAG_VERSION : string : "--version"
FLAG_HELP: string : "--help"

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
