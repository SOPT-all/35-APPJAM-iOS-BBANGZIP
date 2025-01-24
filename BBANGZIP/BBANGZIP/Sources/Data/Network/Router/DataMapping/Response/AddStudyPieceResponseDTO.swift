//
//  AddStudyPieceResponseDTO.swift
//  BBANGZIP
//
//  Created by 최유빈 on 1/24/25.
//  Copyright © 2025 com.bbangzip. All rights reserved.
//

struct AddStudyPieceResponseDTO: Decodable {
    let code: String
    let data: [AddStudyPieceBadgeDTO]?
}

struct AddStudyPieceBadgeDTO: Decodable {
    let badgeName: String
    let badgeImage: String
    let hashTags: [String]
}
