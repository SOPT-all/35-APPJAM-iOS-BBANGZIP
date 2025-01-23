//
//  FetchSubjectResponseDTO.swift
//  BBANGZIP
//
//  Created by 최유빈 on 1/23/25.
//  Copyright © 2025 com.bbangzip. All rights reserved.
//

struct FetchSubjectResponseDTO: Decodable {
    let code: String
    let data: FetchSubjectDTO
}

struct FetchSubjectDTO: Decodable {
    let year: Int
    let semester: Semester
    let subjectList: [SubjectListDTO]
    
    func toDomain() -> SubjectContent {
        SubjectContent(
            year: year,
            semester: semester,
            SubjectList: subjectList.map { $0.toDomain() }
        )
    }
}

struct SubjectListDTO: Decodable {
    let subjectId: Int
    let subjectName: String
    let studyList: [StudyListDTO]
    
    enum CodingKeys: String, CodingKey {
        case subjectId = "subjectId"
        case subjectName
        case studyList
    }
    
    func toDomain() -> SubjectCardModel {
        SubjectCardModel(
            state: .cardDefault,
            subjectId: subjectId,
            subjectName: subjectName,
            studyList: studyList.map { $0.toDomain() }
        )
    }
}

struct StudyListDTO: Decodable {
    let examName: String
    let examDDay: Int
    let pendingCount: Int
    let remainingCount: Int
    
    func toDomain() -> SubjectStudyModel {
        SubjectStudyModel(
            examName: examName,
            examDDay: examDDay,
            pendingCount: pendingCount,
            inProgressCount: remainingCount
        )
    }
}
