//
//  FilterExamResponseDTO.swift
//  BBANGZIP
//
//  Created by 최유빈 on 1/23/25.
//  Copyright © 2025 com.bbangzip. All rights reserved.
//

struct FilterExamResponseDTO: Decodable {
    let code: String
    let data: FilterExamDTO
}

struct FilterExamDTO: Decodable {
    let motivationMessage: String?
    let examDday: Int
    let examDate: String
    let studyList: [ExamListDTO]
    
    func toDomain() -> FilterExamContent {
        FilterExamContent(
            motivationMessage: motivationMessage ?? "",
            examDday: examDday,
            examDate: examDate,
            studyList: studyList.map { $0.toDomain() }
        )
    }
}

struct ExamListDTO: Decodable {
    let pieceId: Int
    let studyContents: String
    let startPage: Int
    let finishPage: Int
    let deadline: String
    let remainingDays: Int
    let isFinished: Bool
    
    enum CodingKeys: String, CodingKey {
        case pieceId = "pieceId"
        case studyContents
        case startPage
        case finishPage
        case deadline
        case remainingDays
        case isFinished
    }
    
    func toDomain() -> FilterExamList {
        FilterExamList(
            pieceId: pieceId,
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
