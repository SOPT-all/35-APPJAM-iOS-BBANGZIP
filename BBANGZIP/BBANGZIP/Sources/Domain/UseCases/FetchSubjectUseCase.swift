//
//  FetchSubjectUseCase.swift
//  BBANGZIP
//
//  Created by 최유빈 on 1/23/25.
//  Copyright © 2025 com.bbangzip. All rights reserved.
//

protocol FetchSubjectUseCase: Sendable {
    func execute(
        year: Int,
        semester: Semester
    ) async throws -> SubjectContent
}

final class DefaultFetchSubjectUseCase {
    private let subjectRepository: SubjectRepository

    init(subjectRepository: SubjectRepository) {
        self.subjectRepository = subjectRepository
    }
}

extension DefaultFetchSubjectUseCase: FetchSubjectUseCase {
    func execute(
        year: Int,
        semester: Semester
    ) async throws -> SubjectContent {
        return try await subjectRepository.fetchSubject(
            year: year,
            semester: semester
        )
    }
}
