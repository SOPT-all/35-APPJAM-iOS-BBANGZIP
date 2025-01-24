//
//  BadgeList.swift
//  BBANGZIP
//
//  Created by 송여경 on 1/24/25.
//  Copyright © 2025 com.bbangzip. All rights reserved.
//

enum BadgeCategory: String, CaseIterable, Hashable {
    case start = "시작이 빵이다"
    case escape = "미룬이 탈출"
    case almostEscape = "미룬이 겨우 탈출"
    case insider = "인싸 사장님"
    case none = "서버가 잘못했어"
    
    var subtitle: String {
        switch self {
        case .start:
            "이번 학기 빵점 탈출 내가 해냄!"
        case .escape:
            "지금 바로 시작하면 미룬이 탈출 가능!"
        case .almostEscape:
            "미룬이 탈출 막차 탑승!"
        case .insider:
            "빵 한 쪽도 나눠 먹는 사이!"
        case .none:
            "서버가 잘못했으니까 가서 따질게~"
        }
    }
}

struct BadgeDictionaryModel {
    let nickname: String
    let badgeCategoryList: [BadgeListModel]
}

struct BadgeListModel: Hashable {
    let badgeCategry: BadgeCategory
    let badgeList: [BadgeModel]
}

struct BadgeModel: Hashable {
    let badgeCategory: String
    let badgeName: String
    let badgeIsLocked: Bool
    let badgeImage: String
}
