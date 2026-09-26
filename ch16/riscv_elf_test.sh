#!/usr/bin/env bash
# Checks that the object file is a 64-bit ELF file for RISC-V: the ELF
# magic, ELFCLASS64 at byte 4, and e_machine 0xf3 at byte 18.
set -euo pipefail
readonly obj="$1"
magic="$(od -An -tx1 -N5 "${obj}" | tr -d ' \n')"
machine="$(od -An -tx1 -j18 -N2 "${obj}" | tr -d ' \n')"
echo "magic=${magic} machine=${machine}"
[[ "${magic}" == "7f454c4602" ]]
[[ "${machine}" == "f300" ]]
