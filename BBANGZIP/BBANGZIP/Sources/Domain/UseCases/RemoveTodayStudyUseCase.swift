//
//  RemoveTodayStudyUseCase.swift
//  BBANGZIP
//
//  Created by 조성민 on 1/22/25.
//  Copyright © 2025 com.bbangzip. All rights reserved.
//

protocol RemoveTodayStudyUseCase: Sendable {
    func execute(pieceIDs: [Int]) async throws
}

final class DefaultRemoveTodayStudyUseCase {
    private let repository: StudyRepository
    
    init(repository: StudyRepository) {
        self.repository = repository
    }
}

extension DefaultRemoveTodayStudyUseCase: RemoveTodayStudyUseCase {
    func execute(pieceIDs: [Int]) async throws {
        return try await repository.removeTodayStudy(pieceIDs: pieceIDs)
    }
}
