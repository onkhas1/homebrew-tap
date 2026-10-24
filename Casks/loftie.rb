cask "loftie" do
  version "1.0.2"
  sha256 "ec8e0c1aa95b4580cad5a95b3dae919ed2ce32cb7b21ca8d512aed0ed7486b4e"

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
