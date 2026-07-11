class Nr < Formula
  desc "TUI-based npm script runner with fuzzy search"
  homepage "https://github.com/juicyjusung/nr"
  version "0.2.3"
  license "MIT"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/juicyjusung/nr/releases/download/v0.2.3/nr-v0.2.3-aarch64-apple-darwin.tar.gz"
      sha256 "e035132305ac409d8bdc1130455356d6d6aa519d39ddb61410497f874bb4d5bf"
    else
      url "https://github.com/juicyjusung/nr/releases/download/v0.2.3/nr-v0.2.3-x86_64-apple-darwin.tar.gz"
      sha256 "e35b8943796b3080e0b048757fb986bd8cb4e47995e584c345df3009a781cc6e"
    end
  end

  on_linux do
    if Hardware::CPU.arm?
      url "https://github.com/juicyjusung/nr/releases/download/v0.2.3/nr-v0.2.3-aarch64-unknown-linux-gnu.tar.gz"
      sha256 "8388e94c883f389b41784f0712441e32028b59e490240a2ece7f00bc98361f58"
    else
      url "https://github.com/juicyjusung/nr/releases/download/v0.2.3/nr-v0.2.3-x86_64-unknown-linux-gnu.tar.gz"
      sha256 "ce59de7fe76466de514e7b1852b726e03f579b940375648be9ebe4339497823a"
    end
  end

  def install
    bin.install "nr"
  end

  test do
    assert_match "nr", shell_output("#{bin}/nr --help 2>&1")
  end
end
