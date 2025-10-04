const std = @import("std");

const print = std.debug.print;
const fs = std.fs;

// Implementation:
// Use a buffer of size 2048 bytes
// While reading the contents of the file's stream:
// - Every character is put into the buffer
// - if We run into a \n, we close the buffer and print its contents
// - When we reach the end of the stream, we cleanup the buffer and exit the program

pub fn main() !void {
    var buffer: [2048]u8 = undefined;

    const cwd = fs.cwd();
    if(cwd.openFile("input.txt", .{})) |file| {
        var i: u8 = 0;

        while(true) {
            const x = try file.reader().readUntilDelimiterOrEof(&buffer, '\n');

            if(x) |y|{
                print("{d}:\t", .{i});
                for(0..y.len) |c| {
                    print("{c}", .{buffer[c]});
                }

                print("\n", .{});
            }else {
                break;
            }

            i += 1;
        }
    }else |_| {
        print("Cannot open file", .{});
    }
}
