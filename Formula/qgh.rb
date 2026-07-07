class Qgh < Formula
  desc "Local-first GitHub Issues retrieval CLI"
  homepage "https://github.com/juicyjusung/qgh"
  version "0.1.0"

  def self.github_release_headers
    headers = ["Accept: application/octet-stream"]
    token = ENV["HOMEBREW_GITHUB_API_TOKEN"]
    headers << "Authorization: Bearer #{token}" unless token.to_s.empty?
    headers
  end

  if OS.mac?
    if Hardware::CPU.arm?
      url "https://api.github.com/repos/juicyjusung/qgh/releases/assets/468710082",
          headers: github_release_headers
      sha256 "dc9e66e8abd04b3175519236cb191c46c4730cb11a4845e83af88464d917e017"
    end
    if Hardware::CPU.intel?
      url "https://api.github.com/repos/juicyjusung/qgh/releases/assets/468710083",
          headers: github_release_headers
      sha256 "c9c70761ae8bf19ea21f40f53f675ab81a40822f4f75fc2253e1e1e79e128649"
    end
  end
  if OS.linux? && Hardware::CPU.intel?
    url "https://api.github.com/repos/juicyjusung/qgh/releases/assets/468710088",
        headers: github_release_headers
    sha256 "a7427bf7e66a58237bcd330e257a012a2c953d24ce5d269e9de10dd2aec3b3e5"
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
