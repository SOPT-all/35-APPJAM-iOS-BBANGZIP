//
//  SampleStudyData.swift
//  BBANGZIP
//
//  Created by 최유빈 on 1/16/25.
//  Copyright © 2025 com.bbangzip. All rights reserved.
//

import SwiftUI

struct SampleStudyData {
    let subjectName: String
    let examName: String
    let studyContents: String
    let startPage: Int
    let finishPage: Int
    let deadline: String
    let remainingDays: Int
}

extension SampleStudyData {
    static let sampleStudy: SampleStudyData = SampleStudyData(
        subjectName: "경제통계학개론",
        examName: "중간고사",
        studyContents: "[경영] 통계 PPT 1과",
        startPage: 11,
        finishPage: 20,
        deadline: "2025년 3월 26일",
        remainingDays: -18
    )
}
