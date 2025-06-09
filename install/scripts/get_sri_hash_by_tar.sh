#!/usr/bin/env sh 

set -euo pipefail

if [ "$#" -ne 1 ]; then
    echo "usage: $0 <url-to-tarball>"
    exit
fi

url=$1

hash="$(nix-prefetch-url --unpack "$url")"
sri_hash="$(nix hash convert --hash-algo sha256 --to sri "${hash}")"

printf "SRI hash: %s\n" "$sri_hash"
