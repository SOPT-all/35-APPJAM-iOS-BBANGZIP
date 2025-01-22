//
//  FetchTodayStudySortOption.swift
//  BBANGZIP
//
//  Created by 조성민 on 1/21/25.
//  Copyright © 2025 com.bbangzip. All rights reserved.
//

enum FetchTodayStudySortOption: String, Encodable, CaseIterable {
    case recent
    case leastVolume
    case nearestDeadline
    
    var buttonTitle: String {
        switch self {
        case .recent:
            "최근 등록 순"
        case .leastVolume:
            "분량 적은 순"
        case .nearestDeadline:
            "마감 기한 빠른 순"
        }
    }
}
