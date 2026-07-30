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
      sha256 "7ca3b744f4d92212dd30e8013e8fd1dcd07a84063c3db5b1fdae3cb54e64009e"
    end
    on_intel do
      url "https://github.com/Korel/zmx/releases/download/fork-v#{version}/zmx-#{version}-macos-x86_64.tar.gz"
      sha256 "c05e2cf474916fb52380bab71ab33cfd82c2c344b92d2b4bfa4f2180d4f5f142"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/Korel/zmx/releases/download/fork-v#{version}/zmx-#{version}-linux-aarch64.tar.gz"
      sha256 "84cde23b3c2e9fa37a173c884ffb4b20e865b55e19db2a167a8e0c2759ba1238"
    end
    on_intel do
      url "https://github.com/Korel/zmx/releases/download/fork-v#{version}/zmx-#{version}-linux-x86_64.tar.gz"
      sha256 "dc1ab3271be3de769e2e603e0b2a69c9ba4d9d5498d9a127b65d2100a435e292"
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
