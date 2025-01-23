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

extension SubjectCardModel {
    static let mockList: [Self] = [
        .init(
            state: SubjectCardState.cardDefault,
            subjectId: 1,
            subjectName: "경제통계학",
            studyList: [SubjectStudyModel(
                examName: "중간고사",
                examDDay: 14,
                pendingCount: 2,
                inProgressCount: 1
            )]
        ),
        .init(
            state: SubjectCardState.cardDefault,
            subjectId: 2,
            subjectName: "컴퓨터프로그래밍1",
            studyList: [SubjectStudyModel(
                examName: "중간고사",
                examDDay: 20,
                pendingCount: 1,
                inProgressCount: 4
            )]
        ),
        .init(
            state: SubjectCardState.cardDefault,
            subjectId: 3,
            subjectName: "한국사와문학",
            studyList: [SubjectStudyModel(
                examName: "기말고사",
                examDDay: 3,
                pendingCount: 0,
                inProgressCount: 0
            )]
        )
    ]
}
