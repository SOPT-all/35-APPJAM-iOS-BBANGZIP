//
//  SubjectCardModel.swift
//  BBANGZIP
//
//  Created by 최유빈 on 1/21/25.
//  Copyright © 2025 com.bbangzip. All rights reserved.
//

struct SubjectCardModel: Sendable, Hashable {
    var state: SubjectCardState
    let subjectId: Int
    let subjectName: String
    let studyList: [SubjectStudyModel]
}

struct SubjectStudyModel: Sendable, Hashable {
    let examName: String
    let examDDay: Int
    let pendingCount: Int
    let inProgressCount: Int
}

extension SubjectStudyModel {
    var isValidExam: Bool {
        return examDDay != 999
    }
}

extension SubjectCardModel {
    var hasValidStudy: Bool {
        guard let firstStudy = studyList.first else { return false }
        return firstStudy.isValidExam
    }
}
