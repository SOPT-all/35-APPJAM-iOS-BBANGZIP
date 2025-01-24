//
//  StudyRepository.swift
//  BBANGZIP
//
//  Created by 조성민 on 1/21/25.
//  Copyright © 2025 com.bbangzip. All rights reserved.
//

protocol StudyRepository: Sendable {
    func fetchTodayStudy(
        area: TodayStudyArea,
        year: Int,
        semester: Semester,
        sortOption: FetchTodayStudySortOption
    ) async throws -> TodayStudyContent
    func completeStudy(pieceID: Int) async throws -> [StudyCompleteBadge]
    func revertCompleteStudy(pieceID: Int) async throws
    func removeTodayStudy(pieceIDs: [Int]) async throws
    func fetchAddTodayStudy(
        year: Int,
        semester: Semester,
        sortOption: FetchTodayStudySortOption
    ) async throws -> AddTodayStudyData
}
