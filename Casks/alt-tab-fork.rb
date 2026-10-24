cask "alt-tab-fork" do
  version "11.10.1"
  sha256 "916370fa321a1d7f6d0b16d976cf00b27f1e4979df13a743cd5469b33b361541"

  url "https://github.com/Korel/alt-tab-macos/releases/download/fork-v#{version}/AltTab-#{version}-unsigned.dmg"
  name "AltTab (unsigned fork build)"
  desc "Windows-like alt-tab, unsigned build from Korel's fork"
  homepage "https://github.com/Korel/alt-tab-macos"

  depends_on macos: :big_sur

  app "AltTab.app"

  # This DMG is not signed or notarized. Strip the quarantine flag the OS adds
  # on download so Gatekeeper does not block the app as "damaged" on launch.
  postflight_steps do
    run "/usr/bin/xattr",
        args:           ["-dr", "com.apple.quarantine", "{{appdir}}/AltTab.app"],
        writable_paths: ["AltTab.app"],
        writable_base:  :appdir
  end

  zap trash: [
    "~/Library/Caches/com.lwouis.alt-tab-macos",
    "~/Library/Preferences/com.lwouis.alt-tab-macos.plist",
    "~/Library/Saved Application State/com.lwouis.alt-tab-macos.savedState",
  ]
end
