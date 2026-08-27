class ZmxFork < Formula
  desc "Session attach/detach for the terminal (ReleaseFast-VT fork)"
  homepage "https://github.com/Korel/zmx"
  version "0.7.1"
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
      sha256 "63fe8822358551835aa6f8c6d8d2843f3e06c38ea1597be954157b92e99ccb46"
    end
    on_intel do
      url "https://github.com/Korel/zmx/releases/download/fork-v#{version}/zmx-#{version}-macos-x86_64.tar.gz"
      sha256 "153fd4a3075f04190fc32c144bf5f2a2482d4ca162c2484a79ba52d049826bb2"
    end
  end

  on_linux do
    on_arm do
      url "https://github.com/Korel/zmx/releases/download/fork-v#{version}/zmx-#{version}-linux-aarch64.tar.gz"
      sha256 "964f8eefad721fca3990380ae909378f43941a711b4452d67969449f5e9377d1"
    end
    on_intel do
      url "https://github.com/Korel/zmx/releases/download/fork-v#{version}/zmx-#{version}-linux-x86_64.tar.gz"
      sha256 "1dde8decca17b07ad02a73eba54fa07571408c4eea91bf8234f16f12c95c87e0"
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
