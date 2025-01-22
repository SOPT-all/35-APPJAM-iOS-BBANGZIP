//
//  BadgeDetailViewModel.swift
//  BBANGZIP
//
//  Created by 송여경 on 1/22/25.
//  Copyright © 2025 com.bbangzip. All rights reserved.
//

import SwiftUI

final class BadgeDetailViewModel: ObservableObject {
    @Published var badgeName: String
    @Published var badgeImage: String
    @Published var hashTags: [String]
    @Published var achievementCondition: String
    @Published var reward: Int
    @Published var badgeIsLocked: Bool
    
    init(
        badgeName: String = "",
        badgeImage: String = "",
        hashTags: [String] = [],
        achievementCondition: String = "",
        reward: Int,
        badgeIsLocked: Bool = true
    ) {
        self.badgeName = badgeName
        self.badgeImage = badgeImage
        self.hashTags = hashTags
        self.achievementCondition = achievementCondition
        self.reward = reward
        self.badgeIsLocked = badgeIsLocked
    }
}
