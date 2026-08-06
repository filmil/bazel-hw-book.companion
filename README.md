# Companion examples

The example workspace for *Hardware Development with Bazel: Authoring HDL
Rules*. Each target here is a listing from the book, buildable as printed,
so a page and a target can be compared line by line.

```sh
bazel build //ch01:counter_v          # the Chapter 1 tour
bazel build //design/counter:counter_pkg_v
```

The first build is slow and that is the point: `bazel_rules_ghdl` builds
the GHDL compiler itself from Ada source through the `@ghdl` module, so
there is no system install to go stale and nothing to `apt install` before
starting. Later builds hit the cache.

## Layout

```
ch01/            the tour listing, self-contained so it matches the page
ch03/            the macros: legacy, and the symbolic rewrite
ch19/            analysis tests -- providers and actions, no GHDL run
design/util/     a package, and
design/counter/  a counter that depends on it -- two VHDL libraries, one
                 deps edge, which is what makes the book's claim about
                 *derived* compile order demonstrable rather than asserted
```

```sh
bazel build //ch01:counter_v         # the Chapter 1 tour
bazel build //ch03/...               # both macro flavours
bazel test  //ch19:all               # the analysis tests, ~0.1s
```

## The exercise that is also a test

Delete the `deps` line in `design/counter/BUILD.bazel` and the build fails
immediately and locally:

```
design/counter/counter_pkg.vhd:7:9: error: cannot find resource library "util"
```

That failure is the exercise. It is also a CI step, which deletes the edge,
asserts the build fails, and asserts the error is *that* one -- because a
claim a book prints should not be allowed to quietly stop being true.

## Coverage, honestly

Not every listing in the book is here, and the front matter's "every listing
is buildable" overstates what this repository can ever hold. Most listings
are ruleset *internals* -- rule implementations, provider declarations,
`repository_rule` bodies -- which belong to `bazel_rules_ghdl` and
`rules_nvc` themselves and are buildable there. What belongs here is the
user-facing subset: the `BUILD` files a reader writes.

Done: the Chapter 1 tour, the two-library variant, Chapter 3's two macros,
Chapter 19's analysis tests.

Still to add:

- the simulation and test targets of Chapters 11 and 19, which need a
  `rules_nvc` dependency and a testbench
- the RTL-to-bitstream chain of Chapter 22, which needs a licensed Vivado
  and so can only be exercised where one exists

## Versions

Pinned to what the hdlfactory registry actually serves. To check:

```sh
curl -s https://raw.githubusercontent.com/filmil/bazel-registry/main/\
modules/bazel_rules_ghdl/metadata.json | jq -r '.versions[-1]'
```
