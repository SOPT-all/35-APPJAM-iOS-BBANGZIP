import SwiftUI

public struct ContentView: View {
    @StateObject private var kakaoLoginViewModel = KakaoLoginViewModel(
        useCase: DefaultKakaoLoginUseCase(repository: DefaultUserRepository())
    )
    @State private var isLoading = true
    
    public var body: some View {
        ZStack {
            if isLoading {
                SplashView()
            } else {
                if kakaoLoginViewModel.isOnboardingComplete {
                    CustomTabView()
                } else {
                    OnboardingView()
                }
            }
        }
        .onAppear {
            DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                withAnimation {
                    isLoading = false
                }
                kakaoLoginViewModel.kakaoLogin()
            }
        }
        .environmentObject(kakaoLoginViewModel)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

