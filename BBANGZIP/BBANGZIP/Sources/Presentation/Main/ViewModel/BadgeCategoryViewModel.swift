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
    @Published private var badges: [Badge]
    
    var groupedBadges: [String: [Badge]] {
        Dictionary(
            grouping: badges,
            by: { $0.badgeCategory }
        )
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

let mockBadges = [
    Badge(
        badgeCategory: "시작이 빵이다",
        badgeName: "늦깎이 빵집 오픈",
        badgeIsLocked: true,
        badgeImage: "square.and.arrow.up"
    ),
    Badge(
        badgeCategory: "시작이 빵이다",
        badgeName: "빵굽기 시작",
        badgeIsLocked: false,
        badgeImage: "flame"
    ),
    Badge(
        badgeCategory: "시작이 빵이다",
        badgeName: "빵 마스터",
        badgeIsLocked: true,
        badgeImage: "star"
    ),
    Badge(
        badgeCategory: "시작이 빵이다",
        badgeName: "특급 제빵사",
        badgeIsLocked: false,
        badgeImage: "crown"
    ),
    Badge(
        badgeCategory: "미룬이 탈출",
        badgeName: "첫 미로 클리어",
        badgeIsLocked: true,
        badgeImage: "tortoise"
    ),
    Badge(
        badgeCategory: "미룬이 탈출",
        badgeName: "두 번째 미로 클리어",
        badgeIsLocked: false,
        badgeImage: "hare"
    ),
    Badge(
        badgeCategory: "미룬이 탈출",
        badgeName: "미로 챔피언",
        badgeIsLocked: true,
        badgeImage: "star.circle"
    ),
    Badge(
        badgeCategory: "미룬이 겨우 탈출",
        badgeName: "탈출의 대가",
        badgeIsLocked: false,
        badgeImage: "crown"
    ),
    Badge(
        badgeCategory: "미룬이 겨우 탈출",
        badgeName: "탈출 신동",
        badgeIsLocked: true,
        badgeImage: "bolt"
    ),
    Badge(
        badgeCategory: "미룬이 겨우 탈출",
        badgeName: "끝판왕 탈출",
        badgeIsLocked: false,
        badgeImage: "flag.checkered"
    ),
    Badge(
        badgeCategory: "인싸 사장님",
        badgeName: "빵 나눔의 대가",
        badgeIsLocked: false,
        badgeImage: "star"
    ),
    Badge(
        badgeCategory: "인싸 사장님",
        badgeName: "모두의 빵 친구",
        badgeIsLocked: true,
        badgeImage: "person.3"
    ),
    Badge(
        badgeCategory: "인싸 사장님",
        badgeName: "빵 공유 마스터",
        badgeIsLocked: false,
        badgeImage: "hands.sparkles"
    )
]
