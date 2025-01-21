//
//  TodayStudyResponseDTO.swift
//  BBANGZIP
//
//  Created by 조성민 on 1/21/25.
//  Copyright © 2025 com.bbangzip. All rights reserved.
//

struct TodayStudyResponseDTO: Decodable {
    let code: ResponseCodeDTO
    let data: TodayStudyResponseDataDTO
}

struct TodayStudyResponseDataDTO: Decodable {
    let todayCount: Int
    let completeCount: Int
    let pendingCount: Int
    let todoPiecesList: [ToDoPieceDTO]
    
    func toDomain() -> TodayStudyContent {
        TodayStudyContent(
            todayCount: todayCount,
            completeCount: completeCount,
            pendingCount: pendingCount,
            todoPiecesList: todoPiecesList.map { $0.toDomain() }
        )
    }
}

struct ToDoPieceDTO: Decodable {
    let pieceID: Int
    let subjectName: String
    let examName: String
    let studyContents: String
    let startPage: Int
    let finishPage: Int
    let deadline: String
    let remainingDays: Int
    let isFinished: Bool

    enum CodingKeys: String, CodingKey {
        case pieceID = "pieceId"
        case subjectName
        case examName
        case studyContents
        case startPage
        case finishPage
        case deadline
        case remainingDays
        case isFinished
    }
    
    func toDomain() -> StudyPiece {
        StudyPiece(
            id: pieceID,
            subjectName: subjectName,
            examName: examName,
            studyContents: studyContents,
            startPage: startPage,
            finishPage: finishPage,
            deadline: deadline,
            remainingDays: remainingDays,
            isFinished: isFinished,
            state: isFinished ? .complete : .cardDefault
        )
    }
}
