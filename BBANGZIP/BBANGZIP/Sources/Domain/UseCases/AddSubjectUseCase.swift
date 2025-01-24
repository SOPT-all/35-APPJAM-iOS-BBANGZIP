//
//  AddSubjectUseCase.swift
//  BBANGZIP
//
//  Created by 최유빈 on 1/23/25.
//  Copyright © 2025 com.bbangzip. All rights reserved.
//

protocol AddSubjectUseCase: Sendable {
    func execute(
        year: Int,
        semester: Semester,
        subjectName: String
    ) async throws
}

final class DefaultAddSubjectUseCase {
    private let repository: SubjectRepository
    
    init(repository: SubjectRepository) {
        self.repository = repository
    }
}

extension DefaultAddSubjectUseCase: AddSubjectUseCase {
    func execute(
        year: Int,
        semester: Semester,
        subjectName: String
    ) async throws  {
        return try await repository.addSubject(
            year: year,
            semester: semester,
            subjectName: subjectName
        )
    }
}
