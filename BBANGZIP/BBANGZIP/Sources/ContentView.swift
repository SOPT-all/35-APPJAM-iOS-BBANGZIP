import SwiftUI

public struct ContentView: View {
    @StateObject private var viewModel = KakaoLoginViewModel(
        useCase: DefaultKakaoLoginUseCase(
            repository: DefaultUserRepository()
        )
    )
    @State private var isSplashComplete: Bool = false
    
    public var body: some View {
        ZStack {
            if !isSplashComplete {
                SplashView()
                    .onAppear {
                        Task {
                            try await Task.sleep(nanoseconds: 2_000_000_000)
                            isSplashComplete = true
                        }
                    }
            } else {
                if viewModel.isLogin {
                    if viewModel.isOnboardingComplete {
                        CustomTabView()
                    } else {
                        OnboardingView()
                    }
                } else {
                    LoginView(viewModel: viewModel)
                }
            }
        }
    }
}
