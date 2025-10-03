const std = @import("std");

const fs = std.fs;
const print = std.debug.print;
const assert = std.debug.assert;

pub fn main() !void {
    const cwd = fs.cwd();

    if(cwd.openFile("input.txt", fs.File.OpenFlags{ })) |file| {
        // TODO: Read file line by line
        print("file -> {any}", .{file.stat()});
    } else |e| {
        print("Error opening file: {!}", .{e});
    }
}
