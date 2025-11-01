package common

import "core:fmt"
import "core:strings"
import "core:strconv";

FLAG_VERSION 	: string : "--version"
FLAG_HELP		: string : "--help"
FLAG_ZEN		: string : "--zen"

is_flag :: proc(s: string) -> bool {
	return strings.contains(s, "--")
}

handle_flag :: proc(flag: string) {
	switch flag {
		case FLAG_VERSION:
			fmt.println("contra v0.0.1")
		case FLAG_HELP:
			help()
		case FLAG_ZEN:
			zen()
	}
}


help :: proc() {
	handle_flag(FLAG_VERSION)
	fmt.println("\nBuilt with Odin - https://github.com/odin-lang/Odin")
	// TODO: Fix this
	fmt.println(
	`
contra [file | args]
---------
examples
---------
contra file.txt
contra file.txt 40 (prints L40 only)
contra file.txt 40:50 (prints L40-L50)
---------
args
---------

--help			show help
--version		show version
--zen			show zen
	`)
}

zen :: proc() {
	fmt.println("He will win who, prepared himself, waits to take the enemy unprepared.")
}
