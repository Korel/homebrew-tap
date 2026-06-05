cask "alt-tab-fork" do
  version "11.3.0"
  sha256 "f05c1e16bee6a327874056528d8e042660893312d622cf0b1074083c3b04a81b"

  url "https://github.com/Korel/alt-tab-macos/releases/download/fork-v#{version}/AltTab-#{version}-unsigned.dmg"
  name "AltTab (unsigned fork build)"
  desc "Windows-like alt-tab, unsigned build from Korel's fork"
  homepage "https://github.com/Korel/alt-tab-macos"

  depends_on macos: :big_sur

  app "AltTab.app"

  # This DMG is not signed or notarized. Strip the quarantine flag the OS adds
  # on download so Gatekeeper does not block the app as "damaged" on launch.
  postflight do
    system_command "/usr/bin/xattr",
                   args: ["-dr", "com.apple.quarantine", "#{appdir}/AltTab.app"]
  end

  zap trash: [
    "~/Library/Caches/com.lwouis.alt-tab-macos",
    "~/Library/Preferences/com.lwouis.alt-tab-macos.plist",
    "~/Library/Saved Application State/com.lwouis.alt-tab-macos.savedState",
  ]
end
