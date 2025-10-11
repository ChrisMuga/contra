const std = @import("std");
const utils = @import("utils.zig");

const print = std.debug.print;
const fs = std.fs;

/// # Task:
///      - Take a file as command line input and print its output/contents
///      - Input must be a file and not, say, a directory
/// ## Implementation:
///      - Use a buffer of size 2048 bytes
///      - While reading the contents of the file's stream:
///      - Every character is put into the buffer
///      - if We run into a \n, we close the buffer and print its contents
///      - When we reach the end of the stream, we cleanup the buffer and exit the program
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
        const stat = try file.stat();
        if (stat.kind != std.fs.File.Kind.file) {
            print("Error: {s} is not a file\n", .{fileName});
            return;
        }

        var reader = file.reader(&buffer);

        var offset: usize = 0;
        if (reader.readStreaming(&buffer)) |x| {
            offset = x;
        } else |err| {
            print("{any}", .{err});
        }

        var y: usize = 0;
        var lineNo: u8 = 1;

        for (buffer) |c| {
            if (y >= offset - 1) {
                print("\n", .{});
                break;
            }

            if (y == 0) {
                print("{d} \t", .{lineNo});
                lineNo += 1;
            } else {
                if (buffer[y - 1] == '\n') {
                    print("{d} \t", .{lineNo});
                    lineNo += 1;
                }
            }

            print("{c}", .{c});
            y += 1;
        }
    } else |_| {
        utils.echo("Error: Cannot locate/open file");
    }

    // TODO: Cleanup, but how can we do this better?
    buffer = undefined;
}
