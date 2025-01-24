//
//  AddTodayStudyUseCase.swift
//  BBANGZIP
//
//  Created by 조성민 on 1/24/25.
//  Copyright © 2025 com.bbangzip. All rights reserved.
//

protocol AddTodayStudyUseCase: Sendable {
    func execute(piecesIds: [Int]) async throws
}

final class DefaultAddTodayStudyUseCase {
    private let repository: StudyRepository
    
    init(repository: StudyRepository) {
        self.repository = repository
    }
}

extension DefaultAddTodayStudyUseCase: AddTodayStudyUseCase {
    func execute(piecesIds: [Int]) async throws {
        return try await repository.addTodayStudy(pieceIds: piecesIds)
    }
}
