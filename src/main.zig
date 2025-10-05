const std = @import("std");
const utils = @import("utils.zig");

const print = std.debug.print;
const fs = std.fs;

// Task:
// =====================
//      - Take a file as command line input and print its output/contents

// Implementation:
// =====================
//      Use a buffer of size 2048 bytes
//      While reading the contents of the file's stream:
//      - Every character is put into the buffer
//      - if We run into a \n, we close the buffer and print its contents
//      - When we reach the end of the stream, we cleanup the buffer and exit the program

pub fn main() !void {
    var args = std.process.args();

    var argsBuffer: [10][]const u8 = undefined;

    var j: u8 = 0;

    // TODO: Why do we have to do this to get the first N items in the args iterator?
    // NOTE: Iterators do not have a .len field
    while (args.next()) |x| {
        argsBuffer[j] = x;
        j += 1;
    }

    if (j < 2) {
        utils.echo("Please specify file name");
        return;
    }

    const fileName = argsBuffer[1];

    var buffer: [2048]u8 = undefined;

    const cwd = fs.cwd();
    if (cwd.openFile(fileName, .{})) |file| {
        var i: u8 = 0;

        while (true) {
            const x = try file.reader().readUntilDelimiterOrEof(&buffer, '\n');

            if (x) |y| {
                print("{d}:\t", .{i});
                for (0..y.len) |c| {
                    print("{c}", .{buffer[c]});
                }

                print("\n", .{});
            } else {
                break;
            }

            i += 1;
        }
    } else |_| {
        utils.echo("Error: Cannot locate/open file");
    }
}
