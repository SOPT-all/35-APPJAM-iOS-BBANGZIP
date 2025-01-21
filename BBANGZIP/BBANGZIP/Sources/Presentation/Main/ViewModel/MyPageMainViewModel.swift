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
    @Published var maxScore: Int
    @Published var title: String
    @Published var badgeStatement: String
    var levelStateCount: Int
    //TODO: 서버와의 논의 후 image string 여부 결정 예정
    
    init(
        level: Int,
        currentScore: Int,
        badgeCount: Int,
        maxScore: Int,
        title: String,
        badgeStatement: String,
        levelStateCount: Int = 3
    ) {
        self.level = level
        self.currentScore = currentScore
        self.badgeCount = badgeCount
        self.maxScore = maxScore
        self.title = title
        self.badgeStatement = badgeStatement
        self.levelStateCount = levelStateCount
    }
    
    var progress: Double {
        Double(currentScore) / Double(maxScore)
    }
}
