//
//  FetchMyPageUseCase.swift
//  BBANGZIP
//
//  Created by 김송희 on 1/25/25.
//

protocol FetchMyPageUseCase: Sendable {
    func execute() async throws -> FetchMyPageResponseData
}

final class DefaultFetchMyPageUseCase {
    let repository: UserRepository
    
    init(repository: UserRepository) {
        self.repository = repository
    }
}

extension DefaultFetchMyPageUseCase: FetchMyPageUseCase {
    func execute() async throws -> FetchMyPageResponseData {
        return try await repository.fetchMyPage()
    }
}
