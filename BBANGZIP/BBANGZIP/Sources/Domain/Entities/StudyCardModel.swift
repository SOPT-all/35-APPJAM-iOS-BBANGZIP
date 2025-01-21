//
//  StudyCardModel.swift
//  BBANGZIP
//
//  Created by 최유빈 on 1/21/25.
//  Copyright © 2025 com.bbangzip. All rights reserved.
//

struct StudyCardModel: Hashable {
    let motivationMessage: String
    let examDday: Int
    let examDate: String
    let studyList: [StudyPieceModel]
}

struct StudyPieceModel: Hashable {
    let pieceID: Int
    let studyContents: String
    let startPage: Int
    let finishPage: Int
    let deadline: String
    let remainingDays: Int
    let isFinished: Bool
    var state: StudyCardState
}

extension StudyCardModel {
    static let mockList: [Self] = [
        .init(
            motivationMessage: "열심히 공부합시다!",
            examDday: 24,
            examDate: "2025-05-10",
            studyList: [
                StudyPieceModel(
                    pieceID: 1,
                    studyContents: "경제통계학",
                    startPage: 10,
                    finishPage: 35,
                    deadline: "2025-05-01",
                    remainingDays: -5,
                    isFinished: true,
                    state: .cardDefault
                ),
                StudyPieceModel(
                    pieceID: 2,
                    studyContents: "디자인 프로덕트",
                    startPage: 36,
                    finishPage: 60,
                    deadline: "2025-05-07",
                    remainingDays: 1,
                    isFinished: false,
                    state: .cardDefault
                )]
        )
    ]
}

extension StudyPieceModel {
    static let mockList: [Self] = [
        .init(
            pieceID: 1,
            studyContents: "경제통계학",
            startPage: 10,
            finishPage: 35,
            deadline: "2025-05-01",
            remainingDays: -5,
            isFinished: true,
            state: .cardDefault
        ),
        .init(
            pieceID: 2,
            studyContents: "디자인 프로덕트",
            startPage: 36,
            finishPage: 60,
            deadline: "2025-05-07",
            remainingDays: 1,
            isFinished: false,
            state: .cardDefault
        ),
        .init(
            pieceID: 3,
            studyContents: "디자인 프로덕트",
            startPage: 36,
            finishPage: 60,
            deadline: "2025-05-07",
            remainingDays: 1,
            isFinished: false,
            state: .cardDefault
        ),
        .init(
            pieceID: 4,
            studyContents: "디자인 프로덕트",
            startPage: 36,
            finishPage: 60,
            deadline: "2025-05-07",
            remainingDays: 1,
            isFinished: false,
            state: .cardDefault
        ),
        .init(
            pieceID: 5,
            studyContents: "디자인 프로덕트",
            startPage: 36,
            finishPage: 60,
            deadline: "2025-05-07",
            remainingDays: 1,
            isFinished: false,
            state: .cardDefault
        ),
        .init(
            pieceID: 6,
            studyContents: "디자인 프로덕트",
            startPage: 36,
            finishPage: 60,
            deadline: "2025-05-07",
            remainingDays: 1,
            isFinished: false,
            state: .cardDefault
        )
    ]
}
