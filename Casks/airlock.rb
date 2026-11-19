cask "airlock" do
  version "1.0.0"
  sha256 "9e0183fa37d1063c6b62bf4cde1fa8d214d8b6bd444c4fe2b333b4b3965e6f0b"

  url "https://github.com/onkhas1/airlock/releases/download/v#{version}/Airlock-#{version}.zip"
  name "Airlock"
  desc "Pauses AI apps when the VPN drops or a service sees the wrong country"
  homepage "https://github.com/onkhas1/airlock"

  depends_on macos: :sonoma

  app "Airlock.app"

  # Airlock бесплатный и без платной подписи Apple: снимаем пометку «скачано из интернета»
  postflight_steps do
    run "/usr/bin/xattr", args: ["-dr", "com.apple.quarantine", "{{appdir}}/Airlock.app"]
    # Включён автозапуск — перезапустить уже обновлённую версию
    run "/bin/sh", args: ["-c", "[ -f \"$HOME/Library/LaunchAgents/app.airlock.mac.plist\" ] && " \
                                "launchctl kickstart -k gui/$(id -u)/app.airlock.mac || true"]
  end

  # При выходе Airlock сам отпускает всё замороженное
  uninstall launchctl: "app.airlock.mac",
            quit:      "app.airlock.mac",
            delete:    "~/Library/LaunchAgents/app.airlock.mac.plist"

  zap trash: "~/Library/Application Support/Airlock"
end
