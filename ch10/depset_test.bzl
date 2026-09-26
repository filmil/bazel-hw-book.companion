"""Chapter 10's postorder depset listing, run as a unit test.

The listing builds three depsets and shows what to_list() returns. The
body of _postorder_test below is the listing as printed. The test
wrapper around it is added, and the printed result comment becomes an
assertion.
"""

load("@bazel_skylib//lib:unittest.bzl", "asserts", "unittest")

def _postorder_test(ctx):
    env = unittest.begin(ctx)

    base = depset(["grlib.cf"], order = "postorder")
    mid = depset(["techmap.cf"],
                 transitive = [base],
                 order = "postorder")
    top = depset(["gaisler.cf"],
                 transitive = [mid],
                 order = "postorder")

    top.to_list()
    # ["grlib.cf", "techmap.cf", "gaisler.cf"]

    asserts.equals(
        env,
        ["grlib.cf", "techmap.cf", "gaisler.cf"],
        top.to_list(),
    )
    return unittest.end(env)

postorder_test = unittest.make(_postorder_test)
