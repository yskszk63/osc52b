const std = @import("std");

fn usage() noreturn {
    const stderr = std.io.getStdErr().writer();
    stderr.print("usage: osc52b <url>\n", .{}) catch {};

    std.os.exit(255);
}

pub fn main() anyerror!void {
    const alloc = std.heap.page_allocator;

    const ssh_tty_or_null = std.process.getEnvVarOwned(alloc, "SSH_TTY") catch null;

    const stdout = std.io.getStdOut().writer();

    var args = std.process.args();
    if (!args.skip()) {
        usage();
    }
    const arg = args.next() orelse {
        usage();
    };

    var buf: [0x1000]u8 = undefined;
    const b = std.base64.standard.Encoder.encode(&buf, arg);

    try stdout.print("🌏 {s}\n", .{arg});
    if (ssh_tty_or_null) |tty| {
        const fp = try std.fs.openFileAbsolute(tty, .{ .mode = std.fs.File.OpenMode.write_only });
        defer fp.close();

        try fp.writer().print("\x1b]52;c;{s}\x07", .{b});
    } else {
        try stdout.print("\x1b]52;c;{s}\x07", .{b});
    }
}
