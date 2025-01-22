//
//  BadgeDetailResponseDTO.swift
//  BBANGZIP
//
//  Created by 송여경 on 1/23/25.
//  Copyright © 2025 com.bbangzip. All rights reserved.
//

struct BadgeDetailResponseDTO: Decodable {
    let code: String
    let data: BadgeDetailDTO
}

struct BadgeDetailDTO: Decodable {
    let badgeName: String
    let badgeImage: String
    let hashTags: [String]
    let achievementCondition: String
    let reward: Int
    let badgeIsLocked: Bool
    
    func toDomain() -> BadgeDetail {
        return BadgeDetail(
            badgeName: badgeName,
            badgeImage: badgeImage,
            hashTags: hashTags,
            achievementCondition: achievementCondition,
            reward: reward,
            badgeIsLocked: badgeIsLocked
        )
    }
}
