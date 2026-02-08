class Nr < Formula
  desc "TUI-based npm script runner with fuzzy search"
  homepage "https://github.com/juicyjusung/nr"
  license "MIT"
  version "0.1.0"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/juicyjusung/nr/releases/download/v0.1.0/nr-v0.1.0-aarch64-apple-darwin.tar.gz"
      sha256 "557e49e3854afac9e9ed30ab87d64ac16c410e2c06f156782caf56ab50bcf261"
    else
      url "https://github.com/juicyjusung/nr/releases/download/v0.1.0/nr-v0.1.0-x86_64-apple-darwin.tar.gz"
      sha256 "4f7f5cd776cfe7f9a2f80adf47fe10378769bd4c35db7fd11a42b8a10ea306ef"
    end
  end

  on_linux do
    if Hardware::CPU.arm?
      url "https://github.com/juicyjusung/nr/releases/download/v0.1.0/nr-v0.1.0-aarch64-unknown-linux-gnu.tar.gz"
      sha256 "fbed806794ad9257460aea0e9723494c11a43906ccf21f2d0ab6c5edef8383ae"
    else
      url "https://github.com/juicyjusung/nr/releases/download/v0.1.0/nr-v0.1.0-x86_64-unknown-linux-gnu.tar.gz"
      sha256 "ca70df263475b9d1c99e866460e95d5aa14423a5439c3ba36a80366ef3acae8f"
    end
  end

  def install
    bin.install "nr"
  end

  test do
    assert_match "nr", shell_output("#{bin}/nr --help 2>&1", 1)
  end
end
