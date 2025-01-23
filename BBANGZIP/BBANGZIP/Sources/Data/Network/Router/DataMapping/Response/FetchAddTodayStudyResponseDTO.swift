//
//  FetchAddTodayStudyResponseDTO.swift
//  BBANGZIP
//
//  Created by 조성민 on 1/23/25.
//  Copyright © 2025 com.bbangzip. All rights reserved.
//

struct FetchAddTodayStudyResponseDTO: Decodable {
    let code: ResponseCodeDTO
    let data: FetchAddTodayStudyResponseDataDTO
}

struct FetchAddTodayStudyResponseDataDTO: Decodable {
    let todoCount: Int
    let todoList: [AddTodayStudyContentDTO]
    
    func toDomain() -> AddTodayStudyData {
        return AddTodayStudyData(
            count: todoCount,
            list: todoList.map { $0.toDomain() }
        )
    }
}

struct AddTodayStudyContentDTO: Decodable {
    let pieceID: Int
    let subjectName: String
    let examName: String
    let studyContents: String
    let startPage, finishPage: Int
    let deadline: String
    let remainingDays: Int

    enum CodingKeys: String, CodingKey {
        case pieceID = "pieceId"
        case subjectName
        case examName
        case studyContents
        case startPage
        case finishPage
        case deadline
        case remainingDays
    }
    
    func toDomain() -> AddTodayStudyContent {
        return AddTodayStudyContent(
            pieceID: pieceID,
            subjectName: subjectName,
            examName: examName,
            studyContents: studyContents,
            startPage: startPage,
            finishPage: finishPage,
            deadline: deadline,
            remainingDays: remainingDays
        )
    }
}
