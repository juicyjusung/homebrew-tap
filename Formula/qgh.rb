class Qgh < Formula
  desc "Local-first GitHub Issues retrieval CLI"
  homepage "https://github.com/juicyjusung/qgh"
  version "0.1.1"
  if OS.mac? && Hardware::CPU.arm?
    url "https://github.com/juicyjusung/qgh/releases/download/v0.1.1/qgh-aarch64-apple-darwin.tar.xz"
    sha256 "74ea41ad43196464564eda3a4bfc19c0fe48cdb358de648e0deb164f13a4d819"
  end
  if OS.linux? && Hardware::CPU.intel?
    url "https://github.com/juicyjusung/qgh/releases/download/v0.1.1/qgh-x86_64-unknown-linux-gnu.tar.xz"
    sha256 "a41a944efd9c37ce5b125391a19d2cbf995c79bc03ff193cfc80ff2dcecb10b3"
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
