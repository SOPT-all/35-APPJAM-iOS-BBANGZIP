import SwiftUI

public struct ContainerView: View {
    @StateObject private var viewModel = KakaoLoginViewModel(
        useCase: DefaultKakaoLoginUseCase(
            repository: DefaultUserRepository()
        )
    )
    @State private var isSplashComplete: Bool = false
    @State private var isOnboardingComplete: Bool = true
    
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
                    if isOnboardingComplete {
                        CustomTabView()
                    } else {
                        OnboardingView(isOnboardingComplete: $isOnboardingComplete)
                    }
                } else {
                    LoginView(viewModel: viewModel)
                }
            }
        }
    }
}
