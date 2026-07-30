class ZmxFork < Formula
  desc "Session attach/detach for the terminal (ReleaseFast-VT fork)"
  homepage "https://github.com/Korel/zmx"
  version "0.7.0"
  license "MIT"

  # Fork of upstream zmx that compiles the embedded ghostty-vt .ReleaseFast
  # instead of .ReleaseSafe, while keeping zmx's own code .ReleaseSafe.
  #
  # Upstream ghostty-vt panics on `unreachable` while reflowing OSC 8 hyperlinks
  # during a column-shrink resize. Because the VT runs inside the session-owning
  # daemon, a safety-on build turns that into SIGABRT and destroys the session
  # and its scrollback. Safety-off restores ghostty's intended fallback -- drop
  # one hyperlink and keep running -- which is what Ghostty.app itself ships.
  #
  # Upstream reports:
  #   https://github.com/ghostty-org/ghostty/discussions/13522
  #   https://github.com/neurosnap/zmx/issues/215
  #
  # Stopgap. Remove this formula once the upstream fix lands and neurosnap/tap
  # ships a build containing it.

  on_macos do
    on_arm do
      url "https://github.com/Korel/zmx/releases/download/fork-v#{version}/zmx-#{version}-macos-aarch64.tar.gz"
      sha256 "34a5df748d44a40b2aa4a173dcef1695e0a55730950d9c579577de455212c4f3"
    end
    on_intel do
      url "https://github.com/Korel/zmx/releases/download/fork-v#{version}/zmx-#{version}-macos-x86_64.tar.gz"
      sha256 "bdf07eda1606e563daf584ea6f9d89d2e0e724b6480df685f9e2f108aa562033"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/Korel/zmx/releases/download/fork-v#{version}/zmx-#{version}-linux-aarch64.tar.gz"
      sha256 "03861e89b35b496c7100b91ad2f6689961be2924d9f9283f1c5e6d072d8ea187"
    end
    on_intel do
      url "https://github.com/Korel/zmx/releases/download/fork-v#{version}/zmx-#{version}-linux-x86_64.tar.gz"
      sha256 "8d543aaf38f12081d9b5fd460ed9ef7cbafbca78d5618013ac927e2901b5c391"
    end
  end

  conflicts_with "zmx", because: "both install a `zmx` binary"

  def install
    bin.install "zmx"
    generate_completions_from_executable(bin/"zmx", "completions")
  end

  test do
    assert_match version.to_s, shell_output("#{bin}/zmx version")
  end
end
