//
//  WithdrawUseCase.swift
//  BBANGZIP
//
//  Created by 김송희 on 1/25/25.
//

protocol WithdrawUseCase {
    func execute() async throws
}

final class DefaultWithdrawUseCase {
    let repository: UserRepository
    
    init(repository: UserRepository) {
        self.repository = repository
    }
}

extension DefaultWithdrawUseCase: WithdrawUseCase {
    func execute() async throws {
        try await repository.withdraw()
    }
}
