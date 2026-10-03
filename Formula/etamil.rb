class Etamil < Formula
  desc "eTamil, an Indian FinTech DSL"
  homepage "https://etamil.in"
  version "1.4.2"
  license "AGPL-3.0-or-later"

  # Static binaries from the project's GitHub releases. Linux uses the musl
  # builds, so it does not depend on the system glibc.
  on_macos do
    on_arm do
      url "https://github.com/Maruff/eTamil_lang/releases/download/v#{version}/etamil-macos-arm64.tar.gz"
      sha256 "2cdb6fa4d691b96f788bbf8c0246920e4350aa81106a81e1484d15de521e3d07"
    end
    on_intel do
      url "https://github.com/Maruff/eTamil_lang/releases/download/v#{version}/etamil-macos-x64.tar.gz"
      sha256 "f7b69fe672942d1f205293064ff7e04498e41e2e4973e8223cdf196ddad86377"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/Maruff/eTamil_lang/releases/download/v#{version}/etamil-linux-arm64.tar.gz"
      sha256 "3e64427b1c57f47bf3fe46996ba27e03d72f2fc3e755cc8f719fe08e8c551c01"
    end
    on_intel do
      url "https://github.com/Maruff/eTamil_lang/releases/download/v#{version}/etamil-linux-x64.tar.gz"
      sha256 "91e381fd392b4b68954406ef2e0b8ed193be6b139de0ce303070a38bafc0e5ca"
    end
  end

  def install
    libexec.install "etamil"
    pkgshare.install "nUlakam", "examples"
    # ETAMIL_PATH lets  இறக்கு "nUlakam/..."  resolve from any directory.
    (bin/"etamil").write_env_script libexec/"etamil", ETAMIL_PATH: pkgshare
  end

  test do
    assert_match version.to_s, shell_output("#{bin}/etamil --version")
  end
end
