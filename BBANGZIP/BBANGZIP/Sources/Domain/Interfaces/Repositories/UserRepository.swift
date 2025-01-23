//
//  UserRepository.swift
//  BBANGZIP
//
//  Created by 송여경 on 1/23/25.
//  Copyright © 2025 com.bbangzip. All rights reserved.
//

protocol UserRepository: Sendable {
    func kakaoLogin(completion: @escaping (Result<String, Error>) -> Void)
}
