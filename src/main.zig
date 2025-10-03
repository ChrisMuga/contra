const std = @import("std");

const fs = std.fs;
const print = std.debug.print;
const assert = std.debug.assert;

pub fn main() !void {
    const cwd = fs.cwd();

    if(cwd.openFile("input.txt", fs.File.OpenFlags{ })) |file| {
        // TODO: Read file line by line
        print("File found\n", .{});
        print("file ->\n{!}\n", .{file.stat()});

        // Clean up: Close file
        file.close();
    } else |e| {
        print("Error opening file: {!}", .{e});
    }
}
