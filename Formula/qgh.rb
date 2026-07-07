class Qgh < Formula
  desc "Local-first GitHub Issues retrieval CLI"
  homepage "https://github.com/juicyjusung/qgh"
  version "0.1.0"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/juicyjusung/qgh/releases/download/v0.1.0/qgh-aarch64-apple-darwin.tar.xz"
      sha256 "5630582ba2353f485de2bc221baa410c4f7e044e790ce46f69c30de55147f8ec"
    end
    if Hardware::CPU.intel?
      url "https://github.com/juicyjusung/qgh/releases/download/v0.1.0/qgh-x86_64-apple-darwin.tar.xz"
      sha256 "b0349dd617e7524e6e4adf378722d66287610a69cbd7dab9ed2249d83c7ce30d"
    end
  end
  if OS.linux? && Hardware::CPU.intel?
    url "https://github.com/juicyjusung/qgh/releases/download/v0.1.0/qgh-x86_64-unknown-linux-gnu.tar.xz"
    sha256 "006ac5f7d7982cabe96d96fbd387f148c72260b7334fa3bbfc273e740a3a67bb"
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
