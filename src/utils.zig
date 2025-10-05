const std = @import("std");

/// `echo` mimics print("Hello World") in Python3
/// Example usage:
/// - echo("Hello World");
pub fn echo(val: []const u8) void {
    std.debug.print("{s}\n", .{val});
}
