//
//  DeleteSubjectUseCase.swift
//  BBANGZIP
//
//  Created by 최유빈 on 1/23/25.
//  Copyright © 2025 com.bbangzip. All rights reserved.
//

protocol DeleteSubjectUseCase: Sendable {
    func execute(
        year: Int,
        semester: Semester,
        subjectIds: [Int]
    ) async throws
}

final class DefaultDeleteSubjectUseCase {
    private let repository: SubjectRepository
    
    init(repository: SubjectRepository) {
        self.repository = repository
    }
}

extension DefaultDeleteSubjectUseCase: DeleteSubjectUseCase {
    func execute(
        year: Int,
        semester: Semester,
        subjectIds: [Int]
    ) async throws  {
        return try await repository.deleteSubject(
            year: year,
            semester: semester,
            subjectIds: subjectIds
        )
    }
}
