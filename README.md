# homebrew-tap

Personal Homebrew tap for [@xsf72006](https://github.com/xsf72006)'s macOS
apps and CLI tools. Add it once, install anything in the table below by
name.

```sh
brew tap xsf72006/tap
brew install --cask <name>   # for GUI apps in Casks/
brew install <name>          # for CLI tools / libs in Formula/
```

## What's in here

### Casks (GUI apps)

| Cask | Source | Description |
| ---- | ------ | ----------- |
| [`myclip`](Casks/myclip.rb) | [xsf72006/myclip](https://github.com/xsf72006/myclip) | Lightweight clipboard history with a configurable global hotkey |

### Formulae (CLI tools)

_(none yet)_

## Updating

```sh
brew update
brew upgrade --cask <name>
# or
brew upgrade <name>
```

`brew update` refreshes this tap; `brew upgrade` actually swaps the binary.

## Uninstalling

```sh
brew uninstall --cask <name>             # remove the app
brew uninstall --cask --zap <name>       # also remove its support files / prefs
brew untap xsf72006/tap                  # remove this tap entirely
```

## Notes for the maintainer

Each cask/formula has its own source repo. Their release workflows push
updates here automatically via a `TAP_PUSH_TOKEN` secret — see the
"Adding a new project to the tap" section in `xsf72006/myclip`'s personal
RUNBOOK for the recipe.
