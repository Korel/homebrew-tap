# Korel/homebrew-tap

Homebrew tap for [Korel's fork of AltTab](https://github.com/Korel/alt-tab-macos).

## Install

```sh
brew install --cask Korel/tap/alt-tab-fork
```

This installs an **unsigned, un-notarized** build produced automatically from
upstream (`lwouis/alt-tab-macos`) by the fork's CI. The cask strips the macOS
quarantine flag in a `postflight` step so the app launches without the
"damaged / cannot be opened" Gatekeeper error.

> Note: Homebrew removed the `--no-quarantine` flag, so the `postflight xattr`
> step in the cask is what makes the unsigned app launchable.

## Conflict with the official cask

The official `alt-tab` cask installs to the same `/Applications/AltTab.app`.
Uninstall it first if you want the fork build:

```sh
brew uninstall --cask alt-tab
brew install --cask Korel/tap/alt-tab-fork
```

## Updating

`Casks/alt-tab-fork.rb` pins a `version` + `sha256`. It is bumped
automatically by the `update-cask` workflow whenever the fork publishes a new
`fork-v*` release.
