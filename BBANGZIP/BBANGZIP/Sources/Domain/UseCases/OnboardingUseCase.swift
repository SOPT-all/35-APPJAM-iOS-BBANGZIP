//
//  OnboardingUseCase.swift
//  BBANGZIP
//
//  Created by 송여경 on 1/24/25.
//  Copyright © 2025 com.bbangzip. All rights reserved.
//

protocol OnboardingUseCase: Sendable {
    func execute(
        nickname: String,
        year: Int,
        semester: String,
        subjectName: String
    ) async throws
}

final class DefaultOnboardingUseCase {
    let repository: UserRepository
    
    init(repository: UserRepository) {
        self.repository = repository
    }
}

extension DefaultOnboardingUseCase: OnboardingUseCase {
    func execute(
        nickname: String,
        year: Int,
        semester: String,
        subjectName: String
    ) async throws {
        return try await repository.onboard(
            nickname: nickname,
            year: year,
            semester: semester,
            subjectName: subjectName
        )
    }
}
