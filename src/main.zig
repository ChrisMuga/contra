const std = @import("std");

const fs = std.fs;
const print = std.debug.print;

pub fn main() !void {
    const cwd = fs.cwd();

    if(cwd.openFile("input.txt", fs.File.OpenFlags{ })) |file| {
        const stat = try file.stat();

        var gpa = std.heap.GeneralPurposeAllocator(.{}){};
        const allocator = gpa.allocator();

        // TODO: Stream the file and parse it line by line, using separator \n
        const contents = try file.reader().readAllAlloc(allocator, stat.size+1);

        print("{s}", .{contents});

        // Clean up: Close file
        file.close();
    } else |e| {
        print("Error opening file: {!}", .{e});
    }
}
