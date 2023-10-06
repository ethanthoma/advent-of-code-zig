const std = @import("std");

pub fn main() !void {
    // open file
    var file = try std.fs.cwd().openFile("./input", .{});
    defer file.close();

    // buffered reader
    var buf_reader = std.io.bufferedReader(file.reader());
    var in_stream = buf_reader.reader();

    // buffered writer
    const stdout_file = std.io.getStdOut().writer();
    var bw = std.io.bufferedWriter(stdout_file);
    const stdout = bw.writer();

    // line by line printing
    var buffer: [1024]u8 = undefined;
    var currElf: u32 = 0;
    var maxElf: u32 = 0;
    while (try in_stream.readUntilDelimiterOrEof(&buffer, '\n')) |line| {
        if (line.len != 0) {
            var num = try std.fmt.parseInt(u32, line, 10);
            currElf += num;
        } else {
            if (currElf > maxElf) {
                maxElf = currElf;
            }
            currElf = 0;
        }
    }

    try stdout.print("{}\n", .{maxElf});

    // flush buffer
    try bw.flush();
}
