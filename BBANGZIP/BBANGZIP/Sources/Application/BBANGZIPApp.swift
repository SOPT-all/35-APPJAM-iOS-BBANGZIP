import SwiftUI
import KakaoSDKCommon
import KakaoSDKAuth

@main
struct BBANGZIPApp: App {
    init() {
        
        KakaoSDK.initSDK(appKey: Secrets.kakao)
    }
    var body: some Scene {
        WindowGroup {
            MainView().onOpenURL(perform: { url in
                if (AuthApi.isKakaoTalkLoginUrl(url)) {
                    AuthController.handleOpenUrl(url: url)
                }
            })
        }
    }
}
