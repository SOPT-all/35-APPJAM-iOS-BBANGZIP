import SwiftUI

final class ContainerViewModel: ObservableObject {
    @Published var isSplashComplete: Bool = false
    @Published var isOnboardingComplete: Bool = true
    @Published var isLogin: Bool = false
}

struct ContainerView: View {
    @StateObject private var viewModel = ContainerViewModel()
    
    var body: some View {
        ZStack {
            if !viewModel.isSplashComplete {
                SplashView()
                    .onAppear {
                        Task {
                            try await Task.sleep(nanoseconds: 2_000_000_000)
                            viewModel.isSplashComplete = true
                        }
                    }
            } else {
                if viewModel.isLogin {
                    if viewModel.isOnboardingComplete {
                        CustomTabView()
                    } else {
                        OnboardingView(isOnboardingComplete: $viewModel.isOnboardingComplete)
                    }
                } else {
                    LoginView(
                        viewModel: KakaoLoginViewModel(
                            useCase: DefaultKakaoLoginUseCase(
                                repository: DefaultUserRepository()
                            )
                        ),
                        isLogin: $viewModel.isLogin
                    )
                }
            }
        }
    }
}
