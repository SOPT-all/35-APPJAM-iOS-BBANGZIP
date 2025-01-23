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
    
    init(useCase: KakaoLoginUseCase) {
        self.useCase = useCase
    }
    
    func kakaoLogin() {
        useCase.execute { isSuccess in
            print("isSuccess: \(isSuccess)")
        }
    }
}
