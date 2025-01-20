//
//  MyPageMainViewModel.swift
//  BBANGZIP
//
//  Created by 송여경 on 1/21/25.
//  Copyright © 2025 com.bbangzip. All rights reserved.
//

import SwiftUI

final class MyPageMainViewModel: ObservableObject {
    @Published var level: Int
    @Published var currentScore: Int
    @Published var badgeCount: Int
    let maxScore: Int
    let title: String
    
    init(
        level: Int,
        currentScore: Int,
        badgeCount: Int,
        maxScore: Int = 200,
        title: String = "가판대"
    ) {
        self.level = level
        self.currentScore = currentScore
        self.badgeCount = badgeCount
        self.maxScore = maxScore
        self.title = title
    }
    
    var progress: Double {
        Double(currentScore) / Double(maxScore)
    }
}
