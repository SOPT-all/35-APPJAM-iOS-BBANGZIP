//
//  KakaoLoginUseCase.swift
//  BBANGZIP
//
//  Created by 송여경 on 1/23/25.
//  Copyright © 2025 com.bbangzip. All rights reserved.
//

import Foundation

protocol KakaoLoginUseCase {
    func execute(completion: @escaping (Result<String, Error>) -> Void)
}

struct DefaultKakaoLoginUseCase: KakaoLoginUseCase {
    
    private let repository: UserRepository
    
    init(repository: UserRepository) {
        self.repository = repository
    }
    
    func execute(completion: @escaping (Result<String, Error>) -> Void) {
        repository.kakaoLogin { isSucess in
            completion(isSucess)
        }
    }
    
}
