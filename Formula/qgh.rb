class Qgh < Formula
  desc "Local-first GitHub Issues retrieval CLI"
  homepage "https://github.com/juicyjusung/qgh"
  version "0.1.0"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/juicyjusung/qgh/releases/download/v0.1.0/qgh-aarch64-apple-darwin.tar.xz"
      sha256 "fdeb1168a1335a9acac322d115c99ec3724ff61b8a641ba294f695dd3a9a2d29"
    end
    if Hardware::CPU.intel?
      url "https://github.com/juicyjusung/qgh/releases/download/v0.1.0/qgh-x86_64-apple-darwin.tar.xz"
      sha256 "3a1b90b6c60087a3fb8ace6803916e65742d45791a103c81dfd2a3fb81bfd987"
    end
  end
  if OS.linux? && Hardware::CPU.intel?
    url "https://github.com/juicyjusung/qgh/releases/download/v0.1.0/qgh-x86_64-unknown-linux-gnu.tar.xz"
    sha256 "48668496f6e4144e6de23db304ddfd47b19ae94d8b5de8c03c2753ba85901a5d"
  end

  BINARY_ALIASES = {
    "aarch64-apple-darwin":     {},
    "x86_64-apple-darwin":      {},
    "x86_64-unknown-linux-gnu": {},
  }.freeze

  def target_triple
    cpu = Hardware::CPU.arm? ? "aarch64" : "x86_64"
    os = OS.mac? ? "apple-darwin" : "unknown-linux-gnu"

    "#{cpu}-#{os}"
  end

  def install_binary_aliases!
    BINARY_ALIASES[target_triple.to_sym].each do |source, dests|
      dests.each do |dest|
        bin.install_symlink bin/source.to_s => dest
      end
    end
  end

  def install
    bin.install "qgh" if OS.mac? && Hardware::CPU.arm?
    bin.install "qgh" if OS.mac? && Hardware::CPU.intel?
    bin.install "qgh" if OS.linux? && Hardware::CPU.intel?

    install_binary_aliases!

    # Homebrew will automatically install these, so we don't need to do that
    doc_files = Dir["README.*", "readme.*", "LICENSE", "LICENSE.*", "CHANGELOG.*"]
    leftover_contents = Dir["*"] - doc_files

    # Install any leftover files in pkgshare; these are probably config or
    # sample files.
    pkgshare.install(*leftover_contents) unless leftover_contents.empty?
  end
end
