package main

import "core:fmt"
import "core:os";

// Odin language ref: 
// - https://odin-lang.org/docs/overview/
main :: proc(){
	// TODO: Implement file read
	// - https://pkg.odin-lang.org/core/os/#open
	// - https://pkg.odin-lang.org/core/os/#read
	fmt.println("Hellope!")
	fmt.println(len(os.args))

	i: int = 0

	for i < len(os.args) {
		fmt.println(os.args[i])
		i += 1;
	}
}
