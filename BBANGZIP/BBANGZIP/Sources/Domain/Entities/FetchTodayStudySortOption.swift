//
//  FetchTodayStudySortOption.swift
//  BBANGZIP
//
//  Created by 조성민 on 1/21/25.
//  Copyright © 2025 com.bbangzip. All rights reserved.
//

enum FetchTodayStudySortOption: String, Encodable {
    case recent
    case leastVolume
    case nearestDeadline
}
