cask "myclip" do
  version "0.4.0"
  sha256 "1d614ad2e30625880ba5cdf0ddb2aac3b58ac32e3ce8c77cd15e890eddda6a4a"

  url "https://github.com/xsf72006/myclip/releases/download/v#{version}/myclip-#{version}.zip"
  name "myclip"
  desc "Lightweight clipboard history with a configurable global hotkey"
  homepage "https://github.com/xsf72006/myclip"

  depends_on :macos

  app "myclip.app"

  # Legacy myclip installs used a user LaunchAgent. Clean it up so the new
  # SMAppService-based install isn't shadowed. No-op on fresh installs.
  preflight do
    label = "com.myclip.agent"
    system_command "/bin/launchctl",
                   args:         ["bootout", "gui/#{Process.uid}/#{label}"],
                   must_succeed: false
    system_command "/usr/bin/pkill",
                   args:         ["-x", "myclip"],
                   must_succeed: false
    legacy = Pathname(Dir.home)/"Library/LaunchAgents/#{label}.plist"
    legacy.delete if legacy.exist?
  end

  # Ad-hoc signed → strip the quarantine attribute so the first launch isn't
  # blocked by Gatekeeper. Then launch hidden so the app self-registers as a
  # Login Item via SMAppService.
  postflight do
    system_command "/usr/bin/xattr",
                   args:         ["-dr", "com.apple.quarantine", "#{appdir}/myclip.app"],
                   must_succeed: false
    system_command "/usr/bin/open",
                   args:         ["-g", "#{appdir}/myclip.app"],
                   must_succeed: false
  end

  uninstall quit:   "com.myclip.app",
            delete: "/Applications/myclip.app"

  zap trash: [
    "~/Library/Application Support/myclip",
    "~/Library/LaunchAgents/com.myclip.agent.plist",
    "~/Library/Preferences/com.myclip.app.plist",
  ]
end
