#!/bin/bash
set -e

# get SVF
git clone --no-checkout https://github.com/SVF-tools/SVF.git "$FUZZER/repo/SVF"
git -C "$FUZZER/repo/SVF" checkout 3170e83b03eefc15e5a3707e5c52dc726ffcd60a
