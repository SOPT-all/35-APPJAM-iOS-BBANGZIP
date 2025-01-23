//
//  KakaoLoginViewModel.swift
//  BBANGZIP
//
//  Created by 송여경 on 1/23/25.
//  Copyright © 2025 com.bbangzip. All rights reserved.
//

import SwiftUI

final class KakaoLoginViewModel: ObservableObject {
    private let useCase: KakaoLoginUseCase
    @Published var isOnboardingComplete: Bool = false
    
    init(useCase: KakaoLoginUseCase) {
        self.useCase = useCase
    }
    
    func kakaoLogin() {
        useCase.execute { [weak self] isSuccess in
            switch isSuccess {
            case .success(let data):
                self?.isOnboardingComplete = data.isOnboardingComplete
            case .failure(let failure):
                dump(failure)
            }
        }
    }
}
