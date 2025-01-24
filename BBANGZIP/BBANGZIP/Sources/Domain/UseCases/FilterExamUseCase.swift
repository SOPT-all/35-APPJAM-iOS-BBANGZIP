//
//  FilterExamUseCase.swift
//  BBANGZIP
//
//  Created by 최유빈 on 1/23/25.
//  Copyright © 2025 com.bbangzip. All rights reserved.
//

protocol FilterExamUseCase: Sendable {
    func execute(
        subjectId: Int,
        examName: String
    ) async throws -> FilterExamContent
}

final class DefaultFilterExamUseCase {
    private let examRepository: ExamRepository

    init(examRepository: ExamRepository) {
        self.examRepository = examRepository
    }
}

extension DefaultFilterExamUseCase: FilterExamUseCase {
    func execute(
        subjectId: Int,
        examName: String
    ) async throws -> FilterExamContent {
        return try await examRepository.fetchFilterExam(
            subjectId: subjectId,
            examName: examName
        )
    }
}
