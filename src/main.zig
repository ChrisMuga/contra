const std = @import("std");
const fs = std.fs;

const print = std.debug.print;

pub fn main() !void {
    const _file = fs.openFileAbsolute("./input.txt", fs.File.OpenFlags{ });
}
