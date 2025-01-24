//
//  KakaoLoginUseCase.swift
//  BBANGZIP
//
//  Created by 송여경 on 1/23/25.
//  Copyright © 2025 com.bbangzip. All rights reserved.
//

import Foundation

protocol KakaoLoginUseCase {
    func execute(completion: @escaping @Sendable (Result<SignInData, Error>) -> Void)
}

struct DefaultKakaoLoginUseCase: KakaoLoginUseCase {
    private let repository: UserRepository

    init(repository: UserRepository) {
        self.repository = repository
    }

    func execute(completion: @escaping @Sendable (Result<SignInData, Error>) -> Void) {
        repository.kakaoLogin { result in
            switch result {
            case .success(let success):
                Task {
                    do {
                        let signInData = try await repository.signIn(accessToken: success)
                        completion(.success(signInData))
                    } catch {
                        completion(.failure(error))
                    }
                }
            case .failure(let failure):
                completion(.failure(failure))
            }
        }
    }
}
