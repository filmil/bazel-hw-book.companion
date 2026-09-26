<!-- Generated with Stardoc: http://skydoc.bazel.build -->

A public facade for the stardoc listing of Chapter 19.

The listing documents a ruleset's rules.bzl. This file plays that part:
it re-exports the vhdl_testbench macro of Chapter 3, and stardoc renders
its API into rules.md.

<a id="vhdl_testbench"></a>

## vhdl_testbench

<pre>
load("@hdl_bazel_book_examples//ch19:rules.bzl", "vhdl_testbench")

vhdl_testbench(<a href="#vhdl_testbench-name">name</a>, <a href="#vhdl_testbench-srcs">srcs</a>, <a href="#vhdl_testbench-deps">deps</a>, <a href="#vhdl_testbench-entity">entity</a>, <a href="#vhdl_testbench-args">args</a>)
</pre>



**PARAMETERS**


| Name  | Description | Default Value |
| :------------- | :------------- | :------------- |
| <a id="vhdl_testbench-name"></a>name |  <p align="center"> - </p>   |  none |
| <a id="vhdl_testbench-srcs"></a>srcs |  <p align="center"> - </p>   |  none |
| <a id="vhdl_testbench-deps"></a>deps |  <p align="center"> - </p>   |  none |
| <a id="vhdl_testbench-entity"></a>entity |  <p align="center"> - </p>   |  `None` |
| <a id="vhdl_testbench-args"></a>args |  <p align="center"> - </p>   |  `[]` |


