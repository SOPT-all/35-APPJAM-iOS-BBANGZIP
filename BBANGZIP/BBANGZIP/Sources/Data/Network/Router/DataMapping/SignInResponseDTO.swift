//
//  SignInResponseDTO.swift
//  BBANGZIP
//
//  Created by 송여경 on 1/23/25.
//  Copyright © 2025 com.bbangzip. All rights reserved.
//

import Foundation

struct SignInResponseDTO: Decodable {
    let code: String
    let data: SignInDataDTO
}

struct SignInDataDTO: Decodable {
    let accessToken: String
    let refreschToken: String
    let isOnboardingComplete: Bool
}
