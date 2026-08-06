"""Chapter 19's analysis tests, run against a real rule.

`analysistest` analyzes a target and asserts on what it produced --- its
providers and its registered actions --- without executing anything. No
GHDL runs here, so these are milliseconds, which is the point the chapter
makes about the base of the test pyramid.
"""

load("@bazel_rules_ghdl//:rules.bzl", "GhdlProvider")
load("@bazel_skylib//lib:unittest.bzl", "analysistest", "asserts")

def _provider_contract_impl(ctx):
    """Asserts ghdl_library returns a usable GhdlProvider.

    Args:
      ctx: the analysistest context.

    Returns:
      The closed assertion environment.
    """
    env = analysistest.begin(ctx)
    target = analysistest.target_under_test(env)

    asserts.true(
        env,
        GhdlProvider in target,
        "ghdl_library must return GhdlProvider; a consumer indexes it " +
        "with target[GhdlProvider] and gets an analysis error if absent",
    )

    provider = target[GhdlProvider]
    asserts.equals(env, "counter_lib", provider.name)
    asserts.true(
        env,
        provider.cf_file != None,
        "cf_file carries the library catalog; ghdl_verilog derives " +
        "--workdir from it, and no file name recovers it",
    )
    return analysistest.end(env)

provider_contract_test = analysistest.make(_provider_contract_impl)

def _action_contract_impl(ctx):
    """Asserts ghdl_library registers exactly one mnemonic'd GHDL action.

    Args:
      ctx: the analysistest context.

    Returns:
      The closed assertion environment.
    """
    env = analysistest.begin(ctx)
    actions = analysistest.target_actions(env)

    mnemonics = [a.mnemonic for a in actions]
    asserts.true(
        env,
        "GHDL" in mnemonics,
        "the analysis action must carry the GHDL mnemonic: aquery " +
        "filtering and failure headers both key on it. Saw: " +
        str(mnemonics),
    )

    ghdl = [a for a in actions if a.mnemonic == "GHDL"][0]
    outputs = [f.basename for f in ghdl.outputs.to_list()]
    asserts.true(
        env,
        len([o for o in outputs if o.endswith(".cf")]) == 1,
        "exactly one .cf catalog should be declared; the rest of the " +
        "outputs are the junk drawers GHDL writes beside it. Saw: " +
        str(outputs),
    )
    return analysistest.end(env)

action_contract_test = analysistest.make(_action_contract_impl)
