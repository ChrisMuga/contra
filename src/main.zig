pub fn main() !void {
    std.debug.print("All your {s} are belong to us.\n", .{"codebase"});
}

const std = @import("std");

/// This imports the separate module containing `root.zig`. Take a look in `build.zig` for details.
const lib = @import("contra_lib");
