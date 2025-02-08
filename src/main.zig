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

    var items: std.BoundedArray(u8, 4068) = .{};

    // TODO: Look for \n delimiter and create new "row"
    // - This could be in a parser function
    for (buffer.slice()) |item| {
        print("{c}", .{item});
        if (item == '\n') {
            print("{s}\n", .{"new-line"});
            counter += 1;
            // TODO: Create a new []u8 record to store in a larger array to denote "new-item"
        }else{
            try items.insert(counter, item.slice(counter));
        }
    }

    for (items.slice()) |item| {
        print("~~~~~~~~~~~~~> {c}", .{item});
    }

    print("Inputs: {}\n", .{counter});
}
