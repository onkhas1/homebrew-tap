cask "airlock" do
  version "1.0.1"
  sha256 "aa3a9195f9f8db6c70e00ce0946390d959e1c9bb81c9d7d2a317febd2f7aa2f9"

  url "https://github.com/onkhas1/airlock/releases/download/v#{version}/Airlock-#{version}.zip"
  name "Airlock"
  desc "Pauses AI apps when the VPN drops or a service sees the wrong country"
  homepage "https://github.com/onkhas1/airlock"

  depends_on macos: :sonoma

  app "Airlock.app"

  # Airlock бесплатный и без платной подписи Apple: снимаем пометку «скачано из интернета»
  # Шаги после установки идут в песочнице Homebrew, поэтому перезапуск после обновления делает сам Airlock:
  # закрытый извне, он просит launchd поднять себя снова — уже новую версию.
  postflight_steps do
    run "/usr/bin/xattr", args: ["-dr", "com.apple.quarantine", "{{appdir}}/Airlock.app"]
  end

  # При выходе Airlock сам отпускает всё замороженное; автозапуск при обновлении не трогаем
  uninstall quit: "app.airlock.mac"

  zap launchctl: "app.airlock.mac",
      trash:     [
        "~/Library/Application Support/Airlock",
        "~/Library/LaunchAgents/app.airlock.mac.plist",
      ]
end
