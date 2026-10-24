cask "loftie" do
  version "1.0.1"
  sha256 "6dd61322d21e2a8ed297c628b092b572544691e3bc4f1a4a26f414d737905004"

  url "https://github.com/onkhas1/loftie/releases/download/v#{version}/Loftie-#{version}.zip"
  name "Loftie"
  desc "Notch panel for MacBook: statuses, favorites, clipboard, music and voice notes"
  homepage "https://github.com/onkhas1/loftie"

  depends_on macos: :sonoma

  app "Loftie.app"

  # Loftie бесплатный и без платной подписи Apple: снимаем пометку «скачано из интернета»
  postflight_steps do
    run "/usr/bin/xattr", args: ["-dr", "com.apple.quarantine", "{{appdir}}/Loftie.app"]
  end

  uninstall quit: "io.github.onkhas1.loftie"

  zap trash: [
    "~/Library/Application Support/Loftie",
    "~/Library/Preferences/io.github.onkhas1.loftie.plist",
  ]
end
