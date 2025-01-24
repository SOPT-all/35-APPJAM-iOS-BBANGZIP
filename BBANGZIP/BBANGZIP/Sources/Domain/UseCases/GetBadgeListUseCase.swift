//
//  GetBadgeListUseCase.swift
//  BBANGZIP
//
//  Created by 송여경 on 1/24/25.
//  Copyright © 2025 com.bbangzip. All rights reserved.
//

protocol GetBadgeListUseCase: Sendable {
    func execute() async throws -> BadgeDictionaryModel
}

final class DefaultGetBadgeListUseCase {
    private let repository: BadgeRepository
    
    init(repository: BadgeRepository) {
        self.repository = repository
    }
}

extension DefaultGetBadgeListUseCase: GetBadgeListUseCase {
    func execute() async throws -> BadgeDictionaryModel {
        try await repository.getBadgeList()
    }
}
