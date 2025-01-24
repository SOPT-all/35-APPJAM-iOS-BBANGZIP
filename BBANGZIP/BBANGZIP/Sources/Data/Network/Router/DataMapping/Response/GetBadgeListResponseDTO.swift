//
//  GetBadgeListResponseDTO.swift
//  BBANGZIP
//
//  Created by 송여경 on 1/24/25.
//  Copyright © 2025 com.bbangzip. All rights reserved.
//

struct GetBadgeListResponseDTO: Decodable {
    let code: ResponseCodeDTO
    let data: BadgeListResponseDTO
}

struct BadgeListResponseDTO: Decodable {
    let nickName: String
    let badgeList: [GetBadgeDTO]
    func toDomain() -> BadgeDictionaryModel {
        let badgeList = badgeList.map { $0.toDomain() }
        let badgeCategoryList = BadgeCategory.allCases.map { category in
            BadgeListModel(
                badgeCategry: category,
                badgeList: badgeList.filter { $0.badgeCategory == category.rawValue }
            )
        }
        
        return BadgeDictionaryModel(
            nickname: nickName,
            badgeCategoryList: badgeCategoryList
        )
    }
}

struct GetBadgeDTO: Decodable {
    let badgeCategory: String
    let badgeName: String
    let badgeIsLocked: Bool
    let badgeImage: String
    func toDomain() -> BadgeModel {
        return BadgeModel(
            badgeCategory: badgeCategory,
            badgeName: badgeName,
            badgeIsLocked: badgeIsLocked,
            badgeImage: badgeImage
        )
    }
}
