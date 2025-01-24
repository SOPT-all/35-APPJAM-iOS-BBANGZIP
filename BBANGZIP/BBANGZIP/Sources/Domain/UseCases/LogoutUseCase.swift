//
//  LogoutUseCase.swift
//  BBANGZIP
//
//  Created by 김송희 on 1/25/25.
//

protocol LogoutUseCase {
    func execute() async throws
}

final class DefaultLogoutUseCase {
    let repository: UserRepository
    
    init(repository: UserRepository) {
        self.repository = repository
    }
}

extension DefaultLogoutUseCase: LogoutUseCase {
    func execute() async throws {
        try await repository.logout()
    }
}
