cask "myclip" do
  version "0.2.1"
  sha256 "39245625fa53c7edc98661b1119fe73f5dde0fe49d97a88f526a30ef44dc3e32"

  url "https://github.com/xsf72006/myclip/releases/download/v#{version}/myclip-#{version}.zip"
  name "myclip"
  desc "Lightweight clipboard history with a configurable global hotkey"
  homepage "https://github.com/xsf72006/myclip"

  # Legacy myclip installs used a user LaunchAgent. Clean it up so the new
  # SMAppService-based install isn't shadowed. No-op on fresh installs.
  preflight do
    label = "com.myclip.agent"
    system_command "/bin/launchctl",
                   args: ["bootout", "gui/#{Process.uid}/#{label}"],
                   must_succeed: false
    system_command "/usr/bin/pkill",
                   args: ["-x", "myclip"],
                   must_succeed: false
    legacy = Pathname(Dir.home)/"Library/LaunchAgents/#{label}.plist"
    legacy.delete if legacy.exist?
  end

  app "myclip.app"

  # Ad-hoc signed → strip the quarantine attribute so the first launch isn't
  # blocked by Gatekeeper. Then launch hidden so the app self-registers as a
  # Login Item via SMAppService.
  postflight do
    system_command "/usr/bin/xattr",
                   args: ["-dr", "com.apple.quarantine", "#{appdir}/myclip.app"],
                   must_succeed: false
    system_command "/usr/bin/open",
                   args: ["-g", "#{appdir}/myclip.app"],
                   must_succeed: false
  end

  uninstall quit:   "com.myclip.app",
            delete: "/Applications/myclip.app"

  zap trash: [
    "~/Library/Application Support/myclip",
    "~/Library/Preferences/com.myclip.app.plist",
    "~/Library/LaunchAgents/com.myclip.agent.plist",
  ]
end
