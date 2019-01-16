#!/usr/bin/env bash

set -ex

# Incorporate TARGET env var to the build and test process
cargo build --all --target "$TARGET" --verbose

# We cannot run arm executables on linux
if [[ $TARGET != arm-unknown-linux-gnueabihf ]] && [[ $TARGET != aarch64-unknown-linux-gnu ]]; then
    cargo test -all --target "$TARGET" --verbose

    # Run 'bat' on its own source code and the README
    cargo run --target "$TARGET" -- src/main.rs README.md --paging=never
fi
