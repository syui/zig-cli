const std = @import("std");

pub fn build(b: *std.build.Builder) void {
    const mode = b.standardReleaseOptions();

    const lib = b.addStaticLibrary("zig-cli", "zig-cli/src/main.zig");
    lib.setBuildMode(mode);
    lib.install();

    const libs = b.addStaticLibrary("nanoid", "zig-nanoid/src/nanoid.zig");
    libs.setBuildMode(mode);
    libs.install();

    const main_tests = b.addTest("zig-cli/src/tests.zig");
    main_tests.setBuildMode(mode);

    const test_step = b.step("test", "Run library tests");
    test_step.dependOn(&main_tests.step);

    const origin = b.addExecutable("random", "example/random.zig");
    origin.addPackagePath("zig-cli", "zig-cli/src/main.zig");
    origin.addPackagePath("nanoid", "zig-nanoid/src/nanoid.zig");
    origin.setBuildMode(mode);
    origin.install();

    b.default_step.dependOn(&origin.step);
}
