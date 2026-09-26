#!/usr/bin/env bash
# Checks that the http_archive patch was applied: the NVC workaround turns
# the pa_msb wrapper function into a constant.
set -euo pipefail
readonly f="$1"
grep -q 'constant pa_msb : integer :=' "${f}"
! grep -q 'function pa_msb return integer' "${f}"
echo "patched: ${f}"
