//
//  AddStudyPieceUseCase.swift
//  BBANGZIP
//
//  Created by 최유빈 on 1/24/25.
//  Copyright © 2025 com.bbangzip. All rights reserved.
//

protocol AddStudyPieceUseCase: Sendable {
    func execute(
        subjectId: Int,
        examName: String,
        studyContents: String,
        examDate: String,
        pieceList: [AddStudyPieceDTO]
    ) async throws -> [AddStudyPieceBadge]
}

final class DefaultAddStudyPieceUseCase {
    private let repository: StudyPieceRepository
    
    init(repository: StudyPieceRepository) {
        self.repository = repository
    }
}

extension DefaultAddStudyPieceUseCase: AddStudyPieceUseCase {
    func execute(
        subjectId: Int,
        examName: String,
        studyContents: String,
        examDate: String,
        pieceList: [AddStudyPieceDTO]
    ) async throws -> [AddStudyPieceBadge] {
        return try await repository.addStudyPiece(
            subjectId: subjectId,
            examName: examName,
            studyContents: studyContents,
            examDate: examDate,
            pieceList: pieceList
        )
    }
}
