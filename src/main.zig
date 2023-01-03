const std = @import("std");

fn usage() noreturn {
    const stderr = std.io.getStdErr().writer();
    stderr.print("usage: osc52b <url>\n", .{}) catch {};

    std.os.exit(255);
}

pub fn main() anyerror!void {
    const stdout = std.io.getStdOut().writer();

    const alloc = std.heap.page_allocator;
    var args = std.process.args();
    if (!args.skip()) {
        usage();
    }
    const arg: []u8 = try args.next(alloc) orelse {
        usage();
    };
    defer alloc.free(arg);

    var buf: [0x1000]u8 = undefined;
    const b = std.base64.standard.Encoder.encode(&buf, arg);

    try stdout.print("🌏 {s}\n", .{arg});
    try stdout.print("\x1b]52;c;{s}\x07", .{b});
}
