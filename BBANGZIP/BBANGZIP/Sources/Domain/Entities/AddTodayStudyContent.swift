//
//  AddTodayStudyContent.swift
//  BBANGZIP
//
//  Created by 조성민 on 1/23/25.
//  Copyright © 2025 com.bbangzip. All rights reserved.
//

struct AddTodayStudyData {
    let count: Int
    let list: [AddTodayStudyContent]
}

struct AddTodayStudyContent {
    let pieceID: Int
    let subjectName: String
    let examName: String
    let studyContents: String
    let startPage, finishPage: Int
    let deadline: String
    let remainingDays: Int
}
