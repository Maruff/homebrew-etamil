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

After a release is published on `eTamil_lang`:

```bash
scripts/update-formula.sh 1.4.3
git diff            # check version and four checksums
brew audit --strict --new Maruff/etamil/etamil
brew test Maruff/etamil/etamil
```

then commit and push. The tap repository must be named `homebrew-etamil` on
GitHub for `brew install Maruff/etamil/etamil` to resolve.
