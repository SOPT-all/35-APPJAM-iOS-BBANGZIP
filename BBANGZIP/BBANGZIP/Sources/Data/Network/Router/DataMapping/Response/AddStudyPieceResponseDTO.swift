//
//  AddStudyPieceResponseDTO.swift
//  BBANGZIP
//
//  Created by 최유빈 on 1/24/25.
//  Copyright © 2025 com.bbangzip. All rights reserved.
//

struct AddStudyPieceResponseDTO: Decodable {
    let code: ResponseCodeDTO
    let data: AddStudyPieceDataDTO
}

struct AddStudyPieceDataDTO: Decodable {
    let badges: [AddStudyPieceBadgeDTO]
    
    func toDomain() -> [AddStudyPieceBadge] {
        
        return badges.map { $0.toDomain() }
    }
}

struct AddStudyPieceBadgeDTO: Decodable {
    let badgeName: String
    let badgeImage: String
    let hashTags: [String]
    
    func toDomain() -> AddStudyPieceBadge {
        AddStudyPieceBadge(
            name: badgeName,
            image: badgeImage,
            hashTags: hashTags
        )
    }
}
