//
//  StudyCompleteResponseDTO.swift
//  BBANGZIP
//
//  Created by 조성민 on 1/22/25.
//  Copyright © 2025 com.bbangzip. All rights reserved.
//

struct StudyCompleteResponseDTO: Decodable {
    let code: ResponseCodeDTO
    let data: StudyCompleteDataDTO
}

struct StudyCompleteDataDTO: Decodable {
    let badges: [BadgeDTO]
}
