//
//  DeleteStudyPieceUseCase.swift
//  BBANGZIP
//
//  Created by 최유빈 on 1/24/25.
//  Copyright © 2025 com.bbangzip. All rights reserved.
//

protocol DeleteStudyPieceUseCase: Sendable {
    func execute(
        pieceIds: [Int]
    ) async throws
}

final class DefaultDeleteStudyPieceUseCase {
    private let repository: ExamRepository
    
    init(repository: ExamRepository) {
        self.repository = repository
    }
}

extension DefaultDeleteStudyPieceUseCase: DeleteStudyPieceUseCase {
    func execute(
        pieceIds: [Int]
    ) async throws  {
        return try await repository.deleteStudyPiece(
            pieceIds: pieceIds
        )
    }
}
