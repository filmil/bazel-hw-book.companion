"""Fetches a hermetic RISC-V GCC toolchain.

OpenSBI is freestanding (built with -nostdlib) but,
since v1.x, requires a linker that can produce
position-independent executables (-pie): the firmware
relocates itself to its runtime load address.
Bare-metal *-elf toolchains generally cannot link
PIEs, so this uses the kernel.org riscv64-linux
"nolibc" cross toolchain: a modern, relocatable GCC
whose ld supports -pie. No libc is linked, so the
Linux target is immaterial.
"""

load("@bazel_tools//tools/build_defs/repo:http.bzl",
     "http_archive")

_GCC_VERSION = "13.2.0"
_URL = ("https://mirrors.edge.kernel.org/pub/tools/" +
        "crosstool/files/bin/x86_64/{v}/x86_64-gcc" +
        "-{v}-nolibc-riscv64-linux.tar.xz").format(
    v = _GCC_VERSION)
_INTEGRITY = (
    "sha256-B8WPRVHmNsvouhZweQnpSsJi9F3I/igDQBGEK9wMdBc=")
_STRIP_PREFIX = "gcc-{v}-nolibc/riscv64-linux".format(
    v = _GCC_VERSION)

_BUILD_FILE = """\
package(default_visibility = ["//visibility:public"])

filegroup(
    name = "all",
    srcs = glob(["**"], exclude = ["**/*.html"]),
)

filegroup(name = "gcc", srcs = ["bin/riscv64-linux-gcc"])
"""

def _riscv_toolchain_impl(module_ctx):
    http_archive(
        name = "opensbi_riscv_toolchain",
        url = _URL,
        integrity = _INTEGRITY,
        strip_prefix = _STRIP_PREFIX,
        build_file_content = _BUILD_FILE,
    )
    return module_ctx.extension_metadata(
        reproducible = True)

riscv_toolchain = module_extension(
    implementation = _riscv_toolchain_impl,
    doc = "Fetches the pinned kernel.org GCC toolchain.",
)
