//
//  KakaoLoginViewModel.swift
//  BBANGZIP
//
//  Created by 송여경 on 1/23/25.
//  Copyright © 2025 com.bbangzip. All rights reserved.
//

import SwiftUI
@MainActor
final class KakaoLoginViewModel: ObservableObject {
    private let useCase: DefaultKakaoLoginUseCase
    @Published var isOnboardingComplete: Bool = false
    @Published var isLogin: Bool = false
    @Published var isLoading = true
    
    init(useCase: DefaultKakaoLoginUseCase) {
        self.useCase = useCase
    }
    
    func kakaoLogin() {
        isLoading = true
        useCase.execute { [weak self] result in
            Task { @MainActor in
                switch result {
                case .success(let data):
                    self?.isOnboardingComplete = data.isOnboardingComplete
                    self?.isLogin = true
                case .failure(let failure):
                    print("Kakao login failed: \(failure)")
                    self?.isLogin = false
                }
                self?.isLoading = false
            }
        }
    }
}
