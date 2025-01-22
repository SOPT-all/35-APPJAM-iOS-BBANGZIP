//
//  BadgeCategoryViewModel.swift
//  BBANGZIP
//
//  Created by 송여경 on 1/22/25.
//  Copyright © 2025 com.bbangzip. All rights reserved.
//

// BadgeCategoryViewModel.swift
//  BBANGZIP
//
//  Created by 송여경 on 1/22/25.
//  Copyright © 2025 com.bbangzip. All rights reserved.
//

import SwiftUI

class BadgeCategoryViewModel: ObservableObject {
    @Published var badges: [Badge]
    
    var groupedBadges: [String: [Badge]] {
        Dictionary(grouping: badges, by: { $0.badgeCategory })
    }
    
    var orderedCategories: [String] {
        [
            "시작이 빵이다",
            "미룬이 탈출",
            "미룬이 겨우 탈출",
            "인싸 사장님"
        ]
    }
    
    init(badges: [Badge]) {
        self.badges = badges
    }
    
    func subtitle(for category: String) -> String {
        switch category {
        case "시작이 빵이다":
            return "이번 학기 빵점 탈출 내가 해냄!"
        case "미룬이 탈출":
            return "지금 바로 시작하면 미룬이 탈출 가능!"
        case "미룬이 겨우 탈출":
            return "미룬이 탈출 막차 탑승!"
        case "인싸 사장님":
            return "빵 한 쪽도 나눠 먹는 사이!"
        default:
            return ""
        }
    }
}

struct Badge {
    let badgeCategory: String
    let badgeName: String
    let badgeIsLocked: Bool
    let badgeImage: String
}
