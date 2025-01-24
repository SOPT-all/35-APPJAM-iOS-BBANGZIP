//
//  StudyPiece.swift
//  BBANGZIP
//
//  Created by 조성민 on 1/21/25.
//  Copyright © 2025 com.bbangzip. All rights reserved.
//

struct StudyPiece: Hashable, Identifiable {
    let id: Int
    let subjectName: String
    let examName: String
    let studyContents: String
    let startPage: Int
    let finishPage: Int
    let deadline: String
    let remainingDays: Int
    let isFinished: Bool
    var state: StudyCardState
}

extension StudyPiece {
    static let mockList: [StudyPiece] = [
        StudyPiece(
            id: 1,
            subjectName: "1",
            examName: "1",
            studyContents: "1",
            startPage: 1,
            finishPage: 2,
            deadline: "2025-01-01",
            remainingDays: 4,
            isFinished: false,
            state: .cardDefault
        ),
        StudyPiece(
            id: 2,
            subjectName: "1",
            examName: "1",
            studyContents: "1",
            startPage: 1,
            finishPage: 2,
            deadline: "2025-01-01",
            remainingDays: 4,
            isFinished: false,
            state: .cardDefault
        ),
        StudyPiece(
            id: 3,
            subjectName: "11111111",
            examName: "122222",
            studyContents: "1",
            startPage: 1,
            finishPage: 2,
            deadline: "2025-01-01",
            remainingDays: 4,
            isFinished: false,
            state: .cardDefault
        ),
        StudyPiece(
            id: 4,
            subjectName: "11111111",
            examName: "122222",
            studyContents: "1",
            startPage: 1,
            finishPage: 2,
            deadline: "2025-01-01",
            remainingDays: 4,
            isFinished: false,
            state: .cardDefault
        ),
        StudyPiece(
            id: 5,
            subjectName: "11111111",
            examName: "122222",
            studyContents: "1",
            startPage: 1,
            finishPage: 2,
            deadline: "2025-01-01",
            remainingDays: 4,
            isFinished: false,
            state: .cardDefault
        )
    ]
}
