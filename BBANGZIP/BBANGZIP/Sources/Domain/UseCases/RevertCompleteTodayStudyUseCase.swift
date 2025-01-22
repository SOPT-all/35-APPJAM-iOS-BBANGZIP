//
//  CompleteTodayStudyUseCase.swift
//  BBANGZIP
//
//  Created by 조성민 on 1/22/25.
//  Copyright © 2025 com.bbangzip. All rights reserved.
//

protocol RevertCompleteTodayStudyUseCase: Sendable {
    func execute(pieceID: Int) async throws
}

final class DefaultRevertCompleteTodayStudyUseCase {
    private let repository: StudyRepository
    
    init(repository: StudyRepository) {
        self.repository = repository
    }
}

extension DefaultRevertCompleteTodayStudyUseCase: RevertCompleteTodayStudyUseCase {
    func execute(pieceID: Int) async throws {
        return try await repository.revertCompleteStudy(pieceID: pieceID)
    }
}
