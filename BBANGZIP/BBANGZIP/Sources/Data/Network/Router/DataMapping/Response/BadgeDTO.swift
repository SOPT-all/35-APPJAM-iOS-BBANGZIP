//
//  BadgeDTO.swift
//  BBANGZIP
//
//  Created by 조성민 on 1/22/25.
//  Copyright © 2025 com.bbangzip. All rights reserved.
//

struct BadgeDTO: Decodable {
    let badgeName: String
    let badgeImage: String
    let hashTags: [String]
    
    func toDomain() -> Badge {
        Badge(
            name: badgeName,
            image: badgeImage,
            hashTags: hashTags
        )
    }
}
