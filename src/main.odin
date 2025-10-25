package main

import "core:fmt"
import "core:os";

// Odin language ref: 
// - https://odin-lang.org/docs/overview/
main :: proc(){
	// TODO: Implement file read
	// - https://pkg.odin-lang.org/core/os/#open
	// - https://pkg.odin-lang.org/core/os/#read

	i: int = 0
	j: int  = len(os.args)

	if j == 2 {
		// TODO: string.contains
		//	- or build custom version of such implementation
		if(os.args[1] == "--version") {
			fmt.println("contra v0.0.1")
		}
	}
}
