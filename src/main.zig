const std = @import("std");

const print = std.debug.print;

pub fn main() !void {
    const file: std.fs.File = std.fs.cwd().openFile("input.txt", .{}) catch |err| {
        print("Error: Could not access the file ({s})", .{@errorName(err)});
        std.process.exit(1);
    };

    defer file.close();

    const reader = file.reader();

    var buffer: std.BoundedArray(u8, 4068) = .{};

    reader.streamUntilDelimiter(buffer.writer(), '~', null) catch |err| {
        if (std.mem.eql(u8, @errorName(err), "EndOfStream")) {}
    };

    var counter: u8 = 0;

    for (buffer.slice()) |item| {
        if (item == '\n') {
            counter += 1;
        }
        print("{c}", .{item});
    }

    print("Inputs: {}\n", .{counter});
}
