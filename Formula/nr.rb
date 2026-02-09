class Nr < Formula
  desc "TUI-based npm script runner with fuzzy search"
  homepage "https://github.com/juicyjusung/nr"
  license "MIT"
  version "0.2.0"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/juicyjusung/nr/releases/download/v0.2.0/nr-v0.2.0-aarch64-apple-darwin.tar.gz"
      sha256 "aa188b63a70be1b6b8daf188ccd1361a22e6ea41bd0d86861ff5378a4aac3bb9"
    else
      url "https://github.com/juicyjusung/nr/releases/download/v0.2.0/nr-v0.2.0-x86_64-apple-darwin.tar.gz"
      sha256 "9f296a4c9af78b9cb2e89a68c9d4ab242a330935c7ae5cf5b9aac9341e9bf77d"
    end
  end

  on_linux do
    if Hardware::CPU.arm?
      url "https://github.com/juicyjusung/nr/releases/download/v0.2.0/nr-v0.2.0-aarch64-unknown-linux-gnu.tar.gz"
      sha256 "04b0373b5799207525aed89359ef80c2dbeed44dcb9ac1bd896ef8ac54923a76"
    else
      url "https://github.com/juicyjusung/nr/releases/download/v0.2.0/nr-v0.2.0-x86_64-unknown-linux-gnu.tar.gz"
      sha256 "37ce8b907e582bbb519af0a046ec2f59a9e7d440d74f43296df19c22912942c5"
    end
  end

  def install
    bin.install "nr"
  end

  test do
    assert_match "nr", shell_output("#{bin}/nr --help 2>&1", 1)
  end
end
