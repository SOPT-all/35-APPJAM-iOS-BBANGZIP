//
//  AddStudyPieceRequestDTO.swift
//  BBANGZIP
//
//  Created by 최유빈 on 1/24/25.
//  Copyright © 2025 com.bbangzip. All rights reserved.
//

struct AddStudyPieceRequestDTO: Encodable {
    let subjectId: Int
    let examName: String
    let studyContent: String
    let examDate: String
    let pieceList: [AddStudyPieceDTO]
}

struct AddStudyPieceDTO: Encodable {
    let startPage: Int
    let finishPage: Int
    let deadline: String
}
