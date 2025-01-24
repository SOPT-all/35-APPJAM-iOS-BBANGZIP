//
//  StudyPieceRepository.swift
//  BBANGZIP
//
//  Created by 최유빈 on 1/24/25.
//  Copyright © 2025 com.bbangzip. All rights reserved.
//

protocol StudyPieceRepository: Sendable {
    func addStudyPiece(
        subjectId: Int,
        examName: String,
        studyContents: String,
        examDate: String,
        pieceList: [AddStudyPieceDTO]
    ) async throws -> [AddStudyPieceBadge]
}
