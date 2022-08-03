const std = @import("std");
const cli = @import("zig-cli");
const RndGen = std.rand.DefaultPrng;

var gpa = std.heap.GeneralPurposeAllocator(.{}){};
const allocator = gpa.allocator();

var app = &cli.Command{
    .name = "random",
    .help = "get random number",
    .action = run_server,
};

pub fn main() !void {
    return cli.run(app, allocator);
}

fn run_server(_: []const []const u8) !void {
    var rnd = RndGen.init(0);
    var some_random_num = rnd.random().int(i32);
    std.log.debug("{d}", .{some_random_num});
}
