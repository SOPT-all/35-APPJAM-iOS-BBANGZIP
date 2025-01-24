//
//  ChangeNameUseCase.swift
//  BBANGZIP
//
//  Created by 최유빈 on 1/24/25.
//  Copyright © 2025 com.bbangzip. All rights reserved.
//

protocol ChangeNameUseCase: Sendable {
    func execute(
        subjectId: Int,
        options: String,
        value: String
    ) async throws
}

final class DefaultChangeNameUseCase {
    private let repository: MessageRepository
    
    init(repository: MessageRepository) {
        self.repository = repository
    }
}

extension DefaultChangeNameUseCase: ChangeNameUseCase {
    func execute(
        subjectId: Int,
        options: String,
        value: String
    ) async throws  {
        return try await repository.motivationMessage(
            subjectId: subjectId,
            options: options,
            value: value
        )
    }
}
