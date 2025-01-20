//
//  SubjectCardData.swift
//  BBANGZIP
//
//  Created by 조성민 on 1/18/25.
//  Copyright © 2025 com.bbangzip. All rights reserved.
//

struct SubjectCardData {
    var title: String
    var test: String
    var chipType: ChipType
    var delayedStudyCount: Int
    var inProgressStudyCount: Int
}

extension SubjectCardData {
    static let mockData = SubjectCardData(
        title: "거시경제학",
        test: "중간고사",
        chipType: .daysLeftBlack(-11),
        delayedStudyCount: 1,
        inProgressStudyCount: 3
    )
}
