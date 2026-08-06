"""The macros of Chapter 3, as printed.

Two flavours of the same idea, so the chapter's argument can be run
rather than read: a legacy macro, and the symbolic macro that Bazel 8
added. Both stamp the same two targets.
"""

load("@bazel_rules_ghdl//:rules.bzl", "ghdl_library", "ghdl_verilog")

def ghdl_verilog_from_sources(name, srcs, unit):
    """Composition: wraps the rule pair behind one call.

    The listing from "What a macro can and can't do", unabridged. Runs at
    loading time and instantiates two rules; it creates no actions and
    returns no providers, because a macro cannot.

    Args:
      name: the name of the resulting netlist target. The library target
        is named after it with a `_lib` suffix -- a convention nothing at
        the call site announces, which is exactly the chapter's point.
      srcs: VHDL sources for the library.
      unit: the top-level unit to synthesize.
    """
    ghdl_library(
        name = "{}_lib".format(name),
        srcs = srcs,
    )
    ghdl_verilog(
        name = name,
        lib = ":{}_lib".format(name),
        unit = unit,
    )

def _symbolic_impl(name, visibility, srcs, unit, **_kwargs):
    """Implementation for the symbolic macro below.

    Args:
      name: supplied by Bazel, not by the caller.
      visibility: supplied by Bazel.
      srcs: declared attribute, typed as a label list.
      unit: declared attribute, typed as a string.
      **_kwargs: the rest, ignored.
    """
    ghdl_library(
        name = "{}_lib".format(name),
        srcs = srcs,
    )
    ghdl_verilog(
        name = name,
        lib = ":{}_lib".format(name),
        unit = unit,
        visibility = visibility,
    )

# The same wrapper with a declared schema. Misspell an attribute here and
# loading fails at the call site naming the unknown attribute, where the
# legacy macro above would swallow it in **kwargs and fail much later,
# somewhere else. Every target it creates must be named {name} or
# {name}_something, which is the naming hygiene the chapter describes as
# enforced rather than merely conventional.
ghdl_verilog_symbolic = macro(
    implementation = _symbolic_impl,
    attrs = {
        "srcs": attr.label_list(allow_files = [".vhd", ".vhdl"]),
        "unit": attr.string(),
    },
)
