class Qgh < Formula
  desc "Local-first GitHub Issues retrieval CLI"
  homepage "https://github.com/juicyjusung/qgh"
  version "0.2.1"
  if OS.mac? && Hardware::CPU.arm?
    url "https://github.com/juicyjusung/qgh/releases/download/v0.2.1/qgh-aarch64-apple-darwin.tar.xz"
    sha256 "9c6361d9db4678c8be80e191cfb7901bc847e8a7a69ce1e9b23ee876530777c6"
  end
  if OS.linux? && Hardware::CPU.intel?
    url "https://github.com/juicyjusung/qgh/releases/download/v0.2.1/qgh-x86_64-unknown-linux-gnu.tar.xz"
    sha256 "ae9df0172349cdb846b22e43cb574d9979bdd8dca1d50135625a64e7deffc6f3"
  end

  BINARY_ALIASES = {
    "aarch64-apple-darwin":     {},
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
