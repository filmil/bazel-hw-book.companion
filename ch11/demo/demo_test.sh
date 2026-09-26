#!/usr/bin/env bash
# Runs the self-extracting archive outside Bazel's runfiles and checks
# that the waveform arrived inside it.
set -euo pipefail
readonly shar="$1"
out="$("${shar}")"
echo "${out}"
grep -q '^waveform: ch11/demo/counter_wave.vcd' <<< "${out}"
grep -q 'date' <<< "${out}" || grep -q 'timescale' <<< "${out}"
