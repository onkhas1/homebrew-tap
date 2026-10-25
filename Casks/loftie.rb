cask "loftie" do
  version "1.0.3"
  sha256 "e5d59b11a5853f3c0eb30570a6f7ead374271c187d86e593b131c491574dab4d"

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
