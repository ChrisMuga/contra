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
/// ## Examples:
///     - ./zig-out/bin/contra example.txt // To print the whole file
///     - ./zig-out/bin/contra example.txt 14 // To print line 14 only
/// TODO: Implementation broke with version bump to 0.16.0-dev.732+2f3234c76. Fix
/// TODO: Implement piping e.g. `git log | contra`
/// TODO: Range of line numbers, e.g `contra src/main.zig 14-18`
pub fn main() !void {
    var args = std.process.args();

    var args_buffer: [10][]const u8 = undefined;

    var j: u8 = 0;

    // We only need args[1-2] here so we'll exit the loop early.
    // NOTE: Iterators do not have a .len field
    while (args.next()) |x| {
        args_buffer[j] = x;
        j += 1;

        if (j == 3) {
            break;
        }
    }

    var specified_line_number: ?u64 = null;

    if (j < 1) {
        utils.echo("Please specify file name");
        return;
    } else if (j == 3) {
        specified_line_number = try std.fmt.parseInt(u64, args_buffer[2], 10);
    }

    const file_name = args_buffer[1];

    const cwd = fs.cwd();
    if (cwd.openFile(file_name, .{})) |file| {
        const stat = try file.stat();
        if (stat.kind != std.fs.File.Kind.file) {
            print("Error: {s} is not a file\n", .{file_name});
            return;
        }

        const file_size = stat.size;

        var arena = std.heap.ArenaAllocator.init(std.heap.page_allocator);
        defer arena.deinit();

        const allocator = arena.allocator();

        const buffer = try allocator.alloc(u8, file_size);
        defer allocator.free(buffer);

        var reader = file.reader(buffer);

        // TODO: There may be a better implementation here...
        if (reader.interface.readSliceAll(buffer)) |_| {} else |err| {
            print("{any}", .{err});
        }

        var y: usize = 0;
        var line_no: u64 = 0;

        if (specified_line_number != null) {
            utils.echo("-------");
        }
        for (buffer) |c| {
            if ((y == 0) or (buffer[y - 1] == '\n')) {
                line_no += 1;
                if (specified_line_number == null or specified_line_number == line_no) {
                    print("{d} \t", .{line_no});
                }
            }

            if (specified_line_number == null or specified_line_number == line_no) {
                print("{c}", .{c});
            }

            y += 1;
        }

        if (specified_line_number == null) {
            utils.echo("-------");
            print("Size: {d} bytes\n", .{file_size});
            utils.echo("-------");
        } else {
            utils.echo("-------");
        }
    } else |_| {
        utils.echo("Error: Cannot locate/open file");
    }
}
