//
//  SignInResponseDTO.swift
//  BBANGZIP
//
//  Created by 송여경 on 1/19/25.
//  Copyright © 2025 com.bbangzip. All rights reserved.
//

struct SignInResponseDTO: Decodable {
    let code: String
    let data: SignInDataDTO
}

struct SignInDataDTO: Decodable {
    let accessToken: String
    let refreshToken: String
    let isOnboardingComplete: Bool
}
