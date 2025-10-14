const std = @import("std");
const utils = @import("utils.zig");

const print = std.debug.print;
const fs = std.fs;

/// # Task:
///      - Take a file as command line input and print its output/contents
///      - Input must be a file and not, say, a directory
///      - Show line numbers
/// ## Implementation:
///     - Use an arena allocator to create a buffer.
///     - Use that buffer to read the file specified.
///     - Obtain the file size in order to know how much buffer memory we need to read the whole file
///     - Parse the file while streaming, if we run into a '\n' character; we use that to denote line numbers
///     - Prepend line number at the beginning of every line, which means we initialize our line numbers at 1.
///     - Deintialize the arena on function close
///     - Free the buffer memory on function close
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

    const cwd = fs.cwd();
    if (cwd.openFile(fileName, .{})) |file| {
        const stat = try file.stat();
        if (stat.kind != std.fs.File.Kind.file) {
            print("Error: {s} is not a file\n", .{fileName});
            return;
        }

        const size = stat.size;

        var arena = std.heap.ArenaAllocator.init(std.heap.page_allocator);
        defer arena.deinit();

        const allocator = arena.allocator();

        const buffer = try allocator.alloc(u8, size);
        defer allocator.free(buffer);

        print("Size: {d} bytes\n-------\n", .{size});
        var reader = file.reader(buffer);

        var offset: usize = 0;
        if (reader.readStreaming(buffer)) |x| {
            offset = x;
        } else |err| {
            print("{any}", .{err});
        }

        var y: usize = 0;
        var lineNo: u64 = 1;

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
}
