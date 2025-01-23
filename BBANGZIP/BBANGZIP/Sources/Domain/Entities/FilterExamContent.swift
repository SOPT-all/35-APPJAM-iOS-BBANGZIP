//
//  FilterExamContent.swift
//  BBANGZIP
//
//  Created by 최유빈 on 1/23/25.
//  Copyright © 2025 com.bbangzip. All rights reserved.
//

struct FilterExamContent {
    let motivationMessage: String
    let examDday: Int
    let examDate: String
    let studyList: [FilterExamList]
}

struct FilterExamList {
    let pieceID: Int
    let studyContents: String
    let startPage: Int
    let finishPage: Int
    let deadline: String
    let remainingDays: Int
    let isFinished: Bool
    var state: StudyPieceCardState
}
