const std = @import("std");

pub fn echo(val: []const u8) void {
    std.debug.print("{s}\n", .{val});
}
