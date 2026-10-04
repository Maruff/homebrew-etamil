# homebrew-etamil

Homebrew tap for [eTamil](https://etamil.in).

```bash
brew install Maruff/etamil/etamil
etamil --version
```

macOS (Apple Silicon and Intel) and Linux (x64 and arm64). No Rust or LLVM is
needed; the formula installs the same static binary the project publishes at
<https://github.com/Maruff/eTamil_lang/releases>.

## Releasing a new version

Nothing to do for a normal release. When a version tag is published on `eTamil_lang`,
its release workflow runs `scripts/update-formula.sh` here and pushes the new version
and the four archive checksums. Pre-release tags (`v1.5.0-rc1`) are skipped. That
needs the secret `HOMEBREW_TAP_TOKEN` on `eTamil_lang`: a fine-grained personal access
token limited to this repository, with Contents read and write. Without it the step
only warns, and the tap is updated by hand:

```bash
scripts/update-formula.sh 1.4.3
git diff            # check version and four checksums
brew audit --strict Maruff/etamil/etamil
brew test Maruff/etamil/etamil
```

then commit and push.

The `test` workflow here installs the formula on macOS (Apple Silicon and Intel) and
Linux (x64 and arm64), runs a Tamil program, checks the library is found, and removes
it. It runs when the formula changes, so the update above is tested as soon as it is
pushed. It downloads the published archives, so it fails until the release it names is
out.

The tap repository must be named `homebrew-etamil` on GitHub for
`brew install Maruff/etamil/etamil` to resolve.
