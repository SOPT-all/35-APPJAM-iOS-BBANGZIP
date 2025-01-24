//
//  ExamRepository.swift
//  BBANGZIP
//
//  Created by 최유빈 on 1/23/25.
//  Copyright © 2025 com.bbangzip. All rights reserved.
//

protocol ExamRepository: Sendable {
    func fetchFilterExam(subjectId: Int, examName: String) async throws -> FilterExamContent
}
