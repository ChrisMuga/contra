const std = @import("std");

const fs = std.fs;
const print = std.debug.print;
const assert = std.debug.assert;

pub fn main() !void {
    const cwd = fs.cwd();

    if(cwd.openFile("input.txt", fs.File.OpenFlags{ })) |file| {
        // TODO: Read file line by line
        // NOTE: Can we use the size of the file, in this case 1615 bytes, to get a buffer from the heap and use that buffer to write to stdout?
        print("File found\n", .{});
        print("file ->\n{!}\n", .{file.stat()});

        // Clean up: Close file
        file.close();
    } else |e| {
        print("Error opening file: {!}", .{e});
    }
}
