cask "citrix-workspace" do
  version "24.11.0.55"
  sha256 "117b2ab2cf24ee7b695bce2c11e6e79de23f32388a49e45c1ab93a59ac74bbb9"

  url "https://downloadplugins.citrix.com/ReceiverUpdates/Prod/Receiver/Mac/CitrixWorkspaceAppUniversal#{version}.pkg"
  name "Citrix Workspace"
  desc "Managed desktop virtualization solution"
  homepage "https://docs.citrix.com/en-us/citrix-workspace"

  livecheck do
    url "https://downloadplugins.citrix.com/ReceiverUpdates/Prod/catalog_macos2.xml"
    strategy :xml do |xml|
      xml.get_elements("//Installers[@name='WorkspaceApp']/Installer/Version")
         .map { |item| item.text&.strip }
    end
  end

  auto_updates true
  depends_on macos: ">= :catalina"

  pkg "CitrixWorkspaceAppUniversal#{version}.pkg"

  uninstall launchctl: [
              "com.citrix.AuthManager_Mac",
              "com.citrix.ctxusbd",
              "com.citrix.CtxWorkspaceHelperDaemon",
              "com.citrix.ctxworkspaceupdater",
              "com.citrix.ReceiverHelper",
              "com.citrix.safariadapter",
              "com.citrix.ServiceRecords",
            ],
            quit:      [
              "Citrix.ServiceRecords",
              "com.citrix.CitrixReceiverLauncher",
              "com.citrix.receiver.nomas",
              "com.citrix.ReceiverHelper",
            ],
            pkgutil:   [
              "com.citrix.common",
              "com.citrix.enterprisebrowserinstaller",
              "com.citrix.ICAClient",
              "com.citrix.ICAClientcwa",
              "com.citrix.ICAClienthdx",
            ]

  zap trash: [
    "~/Library/Application Support/Citrix Receiver",
    "~/Library/Application Support/Citrix Workspace",
    "~/Library/Application Support/Citrix",
    "~/Library/Application Support/com.citrix.CitrixReceiverLauncher",
    "~/Library/Application Support/com.citrix.HdxRtcEngine",
    "~/Library/Application Support/com.citrix.receiver*",
    "~/Library/Application Support/com.citrix.ReceiverUpdater",
    "~/Library/Caches/com.citrix.receiver*",
    "~/Library/HTTPStorages/com.citrix.CitrixReceiverLauncher",
    "~/Library/HTTPStorages/com.citrix.receiver*",
    "~/Library/Logs/Citrix Workspace",
    "~/Library/Preferences/com.citrix.AuthManager.plist",
    "~/Library/Preferences/com.citrix.CitrixReceiverLauncher.plist",
    "~/Library/Preferences/com.citrix.HdxRtcEngine.plist",
    "~/Library/Preferences/com.citrix.receiver*.plist",
    "~/Library/Preferences/com.citrix.Receiver*.plist",
    "~/Library/Saved Application State/com.citrix.receiver.nomas.savedState",
    "~/Library/WebKit/com.citrix.receiver.nomas",
  ]
end
