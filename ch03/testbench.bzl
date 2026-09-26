"""The vhdl_testbench macro of Chapter 3, as printed.

rules_nvc ships this same macro in its root macros.bzl. The listing
omits the load statement; it is added here so the file loads.
"""

load("@rules_nvc//build/nvc:rules.bzl", "vhdl_elaborate", "vhdl_library", "vhdl_run")

def vhdl_testbench(name, srcs, deps, entity=None,
                   args=[]):
    vhdl_library_name = "{}_lib".format(name)
    vhdl_library(
        name = vhdl_library_name,
        srcs = srcs,
        deps = deps,
    )
    e = "{}_tb".format(name)
    if entity:
        e = entity
    vhdl_elaborate(
        name = e,
        library = ":{}".format(vhdl_library_name),
    )
    vhdl_run(
        name = name,
        entity = ":{}".format(e),
        args = args,
    )
