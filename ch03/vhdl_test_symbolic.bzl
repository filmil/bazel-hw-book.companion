"""The symbolic rewrite of vhdl_test from Chapter 3.

The chapter prints the macro() declaration first and the implementation
second. Starlark needs a function defined before its use, so the order
here is reversed. The load statement is added so the file loads.

The implementation listing ends in "..." after the vhdl_library call.
The chapter explains why: the legacy macro names its vhdl_elaborate
target after the entity, and a symbolic macro may only create targets
named {name} or {name}_something. rules_nvc 4.5.2 has no `entity`
attribute on vhdl_elaborate, so the rest of the loop cannot be written
until the ruleset adds one. This file stops where the listing stops.

One line differs from the book. The listing declares `entities` as
attr.string_list(). Attributes of a symbolic macro are configurable by
default, so the implementation receives a select() and the for loop
fails with "type 'select' is not iterable". The attribute is declared
with configurable = False here, which is what the loop needs.
"""

load("@rules_nvc//build/nvc:rules.bzl", "vhdl_library")

def _vhdl_test_impl(name, visibility, srcs, deps,
                    entities, **kwargs):
    for entity in entities:
        vhdl_library(
            name = "{}_{}_lib".format(name, entity),
            srcs = srcs,
            deps = deps,
        )

vhdl_test = macro(
    implementation = _vhdl_test_impl,
    attrs = {
        "srcs": attr.label_list(allow_files = [".vhd", ".vhdl"]),
        "deps": attr.label_list(),
        "entities": attr.string_list(configurable = False),
    },
)
