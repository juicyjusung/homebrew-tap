class Nr < Formula
  desc "TUI-based npm script runner with fuzzy search"
  homepage "https://github.com/juicyjusung/nr"
  license "MIT"
  version "0.2.2"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/juicyjusung/nr/releases/download/v0.2.2/nr-v0.2.2-aarch64-apple-darwin.tar.gz"
      sha256 "bf631a957a291b01cd6fa1a7774cc23f8f08b5512a25dd6ce0140c0fee9562f6"
    else
      url "https://github.com/juicyjusung/nr/releases/download/v0.2.2/nr-v0.2.2-x86_64-apple-darwin.tar.gz"
      sha256 "2441e243615050cd96b348aedb2577b1da4c62b5d3e05e4940dbea4ac51967fb"
    end
  end

  on_linux do
    if Hardware::CPU.arm?
      url "https://github.com/juicyjusung/nr/releases/download/v0.2.2/nr-v0.2.2-aarch64-unknown-linux-gnu.tar.gz"
      sha256 "74dfa440d2a0c3a4233608ff377ae12a63047ba48b182e3a844a7ba678c7c1b3"
    else
      url "https://github.com/juicyjusung/nr/releases/download/v0.2.2/nr-v0.2.2-x86_64-unknown-linux-gnu.tar.gz"
      sha256 "1f0cc001dc2b403e9c5c57f3d8947bc34ea8b349198d653ff5dee583c55085ca"
    end
  end

  def install
    bin.install "nr"
  end

  test do
    assert_match "nr", shell_output("#{bin}/nr --help 2>&1", 1)
  end
end
