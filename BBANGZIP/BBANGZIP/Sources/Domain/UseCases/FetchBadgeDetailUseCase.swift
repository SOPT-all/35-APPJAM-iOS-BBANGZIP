//
//  FetchBadgeDetailUseCase.swift
//  BBANGZIP
//
//  Created by 송여경 on 1/23/25.
//  Copyright © 2025 com.bbangzip. All rights reserved.
//

protocol FetchBadgeDetailUseCase: Sendable {
    func execute(badgeName: String) async throws -> BadgeDetail
}

final class DefaultFetchDetailUseCase {
    private let repository: BadgeRepository
    
    init(repository: BadgeRepository) {
        self.repository = repository
    }
}

extension DefaultFetchDetailUseCase: FetchBadgeDetailUseCase {
    func execute(badgeName: String) async throws -> BadgeDetail {
        try await repository.fetchBadgeDetail(badgeName: badgeName)
    }
}
