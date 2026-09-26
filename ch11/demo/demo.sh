#!/usr/bin/env bash
# Prints the header of the waveform that the counter_wave target recorded.
# Both `bazel run` and the extracted .shar archive start this script in the
# _main directory of its runfiles tree, so a workspace-relative path works.
set -euo pipefail
readonly wave="ch11/demo/counter_wave.vcd"
echo "waveform: ${wave}, $(wc -l < "${wave}") lines"
head -n 5 "${wave}"
