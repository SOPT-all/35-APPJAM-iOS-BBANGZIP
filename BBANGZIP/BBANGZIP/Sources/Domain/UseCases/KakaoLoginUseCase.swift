//
//  KakaoLoginUseCase.swift
//  BBANGZIP
//
//  Created by 송여경 on 1/19/25.
//  Copyright © 2025 com.bbangzip. All rights reserved.
//

protocol KakaoLoginUseCase {
    func execute(completion: @escaping (Bool) -> Void)
}

struct DefaultKakaoLoginUseCase: KakaoLoginUseCase {
    
    private let repository: UserRepository
    
    init(repository: UserRepository) {
        self.repository = repository
    }
    
    func execute(completion: @escaping (Bool) -> Void) {
        repository.kakaoLogin { isSucess in
            completion(isSucess)
            Task {
                await repository.registerKakaoToken()
            }
        }
    }
    
}
