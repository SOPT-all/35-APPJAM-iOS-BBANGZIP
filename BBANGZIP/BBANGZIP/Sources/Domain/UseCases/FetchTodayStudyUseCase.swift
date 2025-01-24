//
//  FetchTodayStudyUseCase.swift
//  BBANGZIP
//
//  Created by 조성민 on 1/21/25.
//  Copyright © 2025 com.bbangzip. All rights reserved.
//

protocol FetchTodayStudyUseCase: Sendable {
    func execute(
        area: TodayStudyArea,
        year: Int,
        semester: Semester,
        sortOption: FetchTodayStudySortOption
    ) async throws -> TodayStudyContent
}

final class DefaultFetchTodayStudyUseCase {
    private let studyRepository: StudyRepository

    init(studyRepository: StudyRepository) {
        self.studyRepository = studyRepository
    }
}

extension DefaultFetchTodayStudyUseCase: FetchTodayStudyUseCase {
    func execute(
        area: TodayStudyArea,
        year: Int,
        semester: Semester,
        sortOption: FetchTodayStudySortOption
    ) async throws -> TodayStudyContent {
        return try await studyRepository.fetchTodayStudy(
            area: area,
            year: year,
            semester: semester,
            sortOption: sortOption
        )
    }
}
