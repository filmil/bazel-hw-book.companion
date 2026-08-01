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
ch01/          the tour listing, self-contained so it matches the page
design/util/     a package, and
design/counter/  a counter that depends on it -- two VHDL libraries, one
                 deps edge, which is what makes the book's claim about
                 *derived* compile order demonstrable rather than asserted
```

Delete the `deps` line in `design/counter/BUILD.bazel` and the build fails
immediately and locally: GHDL cannot find the package, in a sandbox that
honestly does not contain it. That failure is the exercise.

## Coverage, honestly

This repo does **not** yet contain a target for every listing in the book,
and the front matter's "every listing is buildable" overstates what exists
today. Most listings are ruleset *internals* -- rule implementations,
provider declarations, `repository_rule` bodies -- which belong to
`bazel_rules_ghdl` and `rules_nvc` themselves, not to a user's workspace.
They are quoted from those projects and are buildable there.

What belongs here is the user-facing subset: the `BUILD` files a reader
writes. Chapters 1 and the two-library variant are done. Still to add:

- the macro and symbolic-macro wrappers of Chapter 3
- the simulation and test targets of Chapters 11 and 19, which need
  `rules_nvc`
- the RTL-to-bitstream chain of Chapter 22, which needs Vivado and so can
  only be exercised where a licensed install exists

## Versions

Pinned to what the hdlfactory registry actually serves. To check:

```sh
curl -s https://raw.githubusercontent.com/filmil/bazel-registry/main/\
modules/bazel_rules_ghdl/metadata.json | jq -r '.versions[-1]'
```
