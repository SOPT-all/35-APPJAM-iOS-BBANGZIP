import SwiftUI
import KakaoSDKCommon
import KakaoSDKAuth

@main
struct BBANGZIPApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView().onOpenURL(perform: { url in
                if (AuthApi.isKakaoTalkLoginUrl(url)) {
                    AuthController.handleOpenUrl(url: url)
                }
            })
        }
    }
}
