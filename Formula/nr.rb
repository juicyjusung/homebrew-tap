class Nr < Formula
  desc "TUI-based npm script runner with fuzzy search"
  homepage "https://github.com/juicyjusung/nr"
  license "MIT"
  version "0.2.0"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/juicyjusung/nr/releases/download/v0.2.0/nr-v0.2.0-aarch64-apple-darwin.tar.gz"
      sha256 "1757d7f5afa78f211b4a72e61c01c28b9d88d9057bdcee112c9d32a257d5c2c4"
    else
      url "https://github.com/juicyjusung/nr/releases/download/v0.2.0/nr-v0.2.0-x86_64-apple-darwin.tar.gz"
      sha256 "4f569771724afb3560211d2460b0ff68cf4f9c0365b10efb8b7d156a61ccc405"
    end
  end

  on_linux do
    if Hardware::CPU.arm?
      url "https://github.com/juicyjusung/nr/releases/download/v0.2.0/nr-v0.2.0-aarch64-unknown-linux-gnu.tar.gz"
      sha256 "e4ed7ae6662b8824c2d3ca3813403b26426d20036308a4039e51c4f10e49cf1a"
    else
      url "https://github.com/juicyjusung/nr/releases/download/v0.2.0/nr-v0.2.0-x86_64-unknown-linux-gnu.tar.gz"
      sha256 "ef758f3dc61c0d1a5000a8b26c42e98d90d1a298889a04ad8372e0521f391cee"
    end
  end

  def install
    bin.install "nr"
  end

  test do
    assert_match "nr", shell_output("#{bin}/nr --help 2>&1", 1)
  end
end
