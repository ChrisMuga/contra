const std = @import("std");
const utils = @import("utils.zig");

const print = std.debug.print;
const fs = std.fs;

/// # Task:
///      - Take a file as command line input and print its output/contents
///      - Input must be a file and not, say, a directory
///      - Show line numbers
///      - Print specific line numbers if specified e.g contra test.txt 40 - prints L40 only
///      - Print specific range of line numbers if specified e.g contra test.txt 40-50 - prints L40-L50
/// ## Implementation:
///     - Use an arena allocator to create a buffer.
///     - Use that buffer to read the file specified.
///     - Obtain the file size in order to know how much buffer memory we need to read the whole file
///     - Parse the file while streaming, if we run into a '\n' character; we use that to denote line numbers
///     - Prepend line number at the beginning of every line, which means we initialize our line numbers at 1.
///     - Deintialize the arena on function close
///     - Free the buffer memory on function close
/// ### Examples:
///     - ./zig-out/bin/contra example.txt // To print the whole file
///     - ./zig-out/bin/contra example.txt 14 // To print line 14 only
///     - ./zig-out/bin/contra example.txt 14:20 // To print lines 14 to 20

// TODO: Get started with tests
// TODO: contra --help
// TODO: contra --version
// TODO: Implement piping e.g. `git log | contra`
// TODO: Error handling in case:
//  - contra test.txt e (if line specifier A is invalid)
//  - contra test.txt 50: (if line specifier B is not provided)
//  - contra test.txt 50:e (if line specifier B is invalid)
//  - contra test.txt 50-60 ("-" is an invalid delimiter)
//  - contra test.txt 50kk-60sk (either of the specifiers are not non-zero numbers)
pub fn main() !void {
    var args = std.process.args();

    var args_buffer: [10][]const u8 = undefined;

    var j: u8 = 0;

    // We only need args[1-2] here so we'll exit the loop early.
    while (args.next()) |x| {
        args_buffer[j] = x;
        j += 1;

        if (j == 3) {
            break;
        }
    }

    // Specified line number(s) - sln
    var sln_a: ?u64 = null;
    var sln_b: ?u64 = null;

    if (j < 1) {
        utils.echo("Please specify file name");
        return;
    } else if (j == 2) {
        const flag: []const u8 = args_buffer[1];
        utils.handleFlag(flag);
        return;
    } else if (j == 3) {
        utils.cls();
        var range_split = std.mem.splitSequence(u8, args_buffer[2], ":");
        var i: u8 = 0;
        while (range_split.next()) |x| {
            switch (i) {
                0 => {
                    sln_a = try std.fmt.parseInt(u64, x, 10);
                },
                1 => {
                    sln_b = try std.fmt.parseInt(u64, x, 10);
                },
                else => {},
            }
            i += 1;
        }
    }

    const file_name = args_buffer[1];

    if (sln_a != null and sln_b != null) {
        utils.echo("-------");
        print("Showing L{d}-L{d} of {s}\n", .{ sln_a.?, sln_b.?, file_name });
    } else if (sln_a != null and sln_b == null) {
        utils.echo("-------");
        print("Showing {s}:{d}\n", .{ file_name, sln_a.? });
    }

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

        for (buffer) |c| {
            if ((y == 0) or (buffer[y - 1] == '\n')) {
                line_no += 1;
                if (sln_a == null or sln_a == line_no) {
                    if (sln_a == line_no) {
                        utils.echo("-------");
                    }
                    print("{d} \t", .{line_no});
                }

                if (sln_b != null and sln_b.? >= line_no and line_no > sln_a.?) {
                    print("{d} \t", .{line_no});
                }
            }

            if (sln_a == null or sln_a == line_no) {
                print("{c}", .{c});
            }

            if (sln_b != null and (sln_b.? >= line_no and line_no > sln_a.?)) {
                print("{c}", .{c});
            }

            y += 1;
        }

        if (sln_a == null) {
            utils.echo("\n-------");
            print("Size: {d} bytes\n", .{file_size});
            utils.echo("-------");
        } else {
            if (sln_a.? <= line_no) {
                utils.echo("-------");
            } else {
                print("Cannot find line({d}). Max line number is {d}\n", .{ sln_a.?, line_no });
            }
        }
    } else |_| {
        utils.echo("Error: Cannot locate/open file");
    }
}
