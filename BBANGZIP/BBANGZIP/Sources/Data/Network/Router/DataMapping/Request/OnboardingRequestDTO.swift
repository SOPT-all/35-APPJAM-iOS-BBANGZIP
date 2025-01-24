//
//  OnboardingRequestDTO.swift
//  BBANGZIP
//
//  Created by 송여경 on 1/24/25.
//  Copyright © 2025 com.bbangzip. All rights reserved.
//

import Foundation

struct OnboardingRequestDTO: Encodable {
    let nickname: String
    let year: Int
    let semester: String
    let subjectName: String
}
