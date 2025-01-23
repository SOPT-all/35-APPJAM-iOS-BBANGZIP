//
//  SubjectRepository.swift
//  BBANGZIP
//
//  Created by 최유빈 on 1/23/25.
//  Copyright © 2025 com.bbangzip. All rights reserved.
//

protocol SubjectRepository: Sendable {
    func fetchSubject(
        year: Int,
        semester: Semester
    ) async throws -> SubjectContent
    
    func addSubject(
        year: Int,
        semester: Semester,
        subjectName: String
    ) async throws
    
    func deleteSubject(
        year: Int,
        semester: Semester,
        subjectIds: [Int]
    ) async throws
}
