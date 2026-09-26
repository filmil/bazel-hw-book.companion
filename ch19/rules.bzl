"""A public facade for the stardoc listing of Chapter 19.

The listing documents a ruleset's rules.bzl. This file plays that part:
it re-exports the vhdl_testbench macro of Chapter 3, and stardoc renders
its API into rules.md.
"""

load("//ch03:testbench.bzl", _vhdl_testbench = "vhdl_testbench")

vhdl_testbench = _vhdl_testbench
