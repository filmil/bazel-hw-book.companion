"""Chapter 19's analysis test, as printed, with one load path changed.

The listing loads @rules_ghdl//:rules.bzl. The rest of the book loads the
same ruleset as @bazel_rules_ghdl, and MODULE.bazel imports it under that
name, so the second load statement below uses it.
"""

load("@bazel_skylib//lib:unittest.bzl",
     "analysistest", "asserts")
load("@bazel_rules_ghdl//:rules.bzl",
     "GhdlProvider", "ghdl_library")

def _library_contract_test(ctx):
    env = analysistest.begin(ctx)
    tut = analysistest.target_under_test(env)

    # Provider contract.
    info = tut[GhdlProvider]
    asserts.equals(env, "counter_lib", info.name)
    asserts.true(
        env,
        info.cf_file.basename.endswith("-obj08.cf"),
        "expected a GHDL .cf catalog output",
    )

    # Action and flag contracts.
    ghdl_actions = [
        a for a in analysistest.target_actions(env)
        if a.mnemonic == "GHDL"
    ]
    asserts.equals(env, 1, len(ghdl_actions))
    cmd = " ".join(ghdl_actions[0].argv)
    asserts.true(
        env,
        "-P" in cmd,
        "dep library search path flag missing",
    )
    return analysistest.end(env)

library_contract_test = analysistest.make(
    _library_contract_test)

def ghdl_test_suite(name):
    ghdl_library(
        name = "dep_lib",
        srcs = ["pkg.vhd"],
        tags = ["manual"],
    )
    ghdl_library(
        name = "counter_lib",
        srcs = ["counter.vhd"],
        deps = [":dep_lib"],
        tags = ["manual"],
    )
    library_contract_test(
        name = name,
        target_under_test = ":counter_lib",
    )
