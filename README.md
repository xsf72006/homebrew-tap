# homebrew-myclip

Homebrew tap for [myclip](https://github.com/xsf72006/myclip) — a lightweight
native macOS clipboard history with a configurable global hotkey.

## Install

```sh
brew tap xsf72006/myclip
brew install --cask myclip
```

That's it. The cask drops `myclip.app` into `/Applications/`, strips the
quarantine attribute so Gatekeeper doesn't block the ad-hoc-signed binary,
and launches it once so it registers itself as a Login Item (configurable
in the app's Settings).

Press **⌘⇧C** to open the panel.

## Update

```sh
brew upgrade --cask myclip
```

## Uninstall

```sh
brew uninstall --cask myclip            # remove the app
brew uninstall --cask --zap myclip      # also remove ~/Library/Application Support/myclip
brew untap xsf72006/myclip              # remove this tap
```
