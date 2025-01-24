//
//  Badge.swift
//  BBANGZIP
//
//  Created by 조성민 on 1/22/25.
//  Copyright © 2025 com.bbangzip. All rights reserved.
//

import Foundation

struct StudyCompleteBadge: Identifiable, Equatable {
    let id = UUID()
    let name: String
    let image: String
    let hashTags: [String]
}
