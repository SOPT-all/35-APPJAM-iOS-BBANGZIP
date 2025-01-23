//
//  FetchAddTodayStudyUseCase.swift
//  BBANGZIP
//
//  Created by 조성민 on 1/23/25.
//  Copyright © 2025 com.bbangzip. All rights reserved.
//

protocol FetchAddTodayStudyUseCase: Sendable {
    func execute(
        year: Int,
        semester: Semester,
        sortOption: FetchTodayStudySortOption
    ) async throws -> AddTodayStudyData
}

final class DefaultFetchAddTodayStudyUseCase {
    let repository: StudyRepository
    
    init(repository: StudyRepository) {
        self.repository = repository
    }
}

extension DefaultFetchAddTodayStudyUseCase: FetchAddTodayStudyUseCase {
    func execute(
        year: Int,
        semester: Semester,
        sortOption: FetchTodayStudySortOption
    ) async throws -> AddTodayStudyData {
        return try await repository.fetchAddTodayStudy(
            year: year,
            semester: semester,
            sortOption: sortOption
        )
    }
}
