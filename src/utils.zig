const std = @import("std");

/// # Implementation
/// - mimics `print("Hello World")` in Python3
/// ## Example usage:
/// - echo("Hello World");
pub fn echo(val: []const u8) void {
    std.debug.print("{s}\n", .{val});
}

pub fn cls() void {
    std.debug.print("\x1B[2J\x1B[H", .{});
}

pub const FLAG_HELP = "--help";
pub const FLAG_ZEN = "--zen";

/// isFlag checks the 1st command line args to see if it is prepended by "--"
pub fn isFlag(val: []const u8) bool {
    return std.mem.eql(u8, "--", val[0..2]);
}

pub fn handleFlag(flag: []const u8) void {
    if (std.mem.eql(u8, flag, FLAG_HELP)) {
        handleFlagHelp();
    } else if (std.mem.eql(u8, flag, FLAG_ZEN)) {
        handleFlagZen();
    } else {
        std.debug.print("Error: {s} is not a flag\n", .{flag});
    }
}

pub fn handleFlagHelp() void {
    std.debug.print(
        \\ Usage: contra [file | args]
        \\ -----
        \\ contra file.txt
        \\ contra file.txt 40 (prints L40 only)
        \\ contra file.txt 40:50 (prints L40-L50)
        \\ contra --help (shows help)
        \\ -----
        \\  - Take a file as command line input and print its output/contents
        \\  - Input must be a file and not, say, a directory
        \\  - Show line numbers
        \\  - Print specific line numbers if specified e.g contra test.txt 40 - prints L40 only
        \\  - Print specific range of line numbers if specified e.g contra test.txt 40-50 - prints L40-L50
        \\ -----
        \\ args:
        \\ --help                 shows help manual/documentation
        \\ --zen                  shows zen
        \\
    , .{});
}

pub fn handleFlagZen() void {
    echo("\"Dust thou art - to dust returnest; was not spoken of the soul\" ;)");
}
