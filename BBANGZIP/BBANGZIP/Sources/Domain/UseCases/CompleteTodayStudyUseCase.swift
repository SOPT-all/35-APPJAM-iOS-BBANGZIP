//
//  CompleteTodayStudyUseCase.swift
//  BBANGZIP
//
//  Created by 조성민 on 1/22/25.
//  Copyright © 2025 com.bbangzip. All rights reserved.
//

protocol CompleteTodayStudyUseCase: Sendable {
    func execute(pieceID: Int) async throws -> [StudyCompleteBadge]
}

final class DefaultCompleteTodayStudyUseCase {
    private let repository: StudyRepository
    
    init(repository: StudyRepository) {
        self.repository = repository
    }
}

extension DefaultCompleteTodayStudyUseCase: CompleteTodayStudyUseCase {
    func execute(pieceID: Int) async throws -> [StudyCompleteBadge] {
        return try await repository.completeStudy(pieceID: pieceID)
    }
}
