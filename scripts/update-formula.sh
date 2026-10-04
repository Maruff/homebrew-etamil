#!/usr/bin/env bash
# Point the formula at a new eTamil release.
#
#   scripts/update-formula.sh 1.4.3
#
# Reads the .sha256 files published beside each archive, so nothing is
# downloaded twice and the checksums come from the release itself.
set -euo pipefail
VERSION="${1:?usage: update-formula.sh <version, without the v>}"
F="$(cd "$(dirname "$0")/.." && pwd)/Formula/etamil.rb"
BASE="https://github.com/Maruff/eTamil_lang/releases/download/v$VERSION"
sed -i.bak "s/^  version \".*\"/  version \"$VERSION\"/" "$F"
for p in macos-arm64 macos-x64 linux-arm64 linux-x64; do
    sum="$(curl -fsSL --retry 5 --retry-delay 5 --retry-all-errors "$BASE/etamil-$p.tar.gz.sha256" | awk '{print $1}')"
    [ "${#sum}" -eq 64 ] || { echo "bad checksum for $p" >&2; mv "$F.bak" "$F"; exit 1; }
    # the sha256 line directly after this archive's url line
    sed -i.bak "/etamil-$p.tar.gz\"/{n;s/sha256 \".*\"/sha256 \"$sum\"/;}" "$F"
done
rm -f "$F.bak"
echo "Formula now at $VERSION. Review with: git diff"
