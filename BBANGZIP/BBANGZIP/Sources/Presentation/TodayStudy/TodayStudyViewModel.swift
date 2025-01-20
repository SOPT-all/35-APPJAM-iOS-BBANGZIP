//
//  TodayStudyViewModel.swift
//  BBANGZIP
//
//  Created by 조성민 on 1/20/25.
//  Copyright © 2025 com.bbangzip. All rights reserved.
//

import SwiftUI

final class TodayStudyViewModel: ObservableObject {
    private let fetchTodayStudyUseCase: FetchTodayStudyUseCase
    @Published var todayCount: Int = 0
    @Published var completeCount: Int = 0
    @Published var pendingCount: Int = 0
    @Published var todoPiecesList: [StudyPiece] = []
    @Published var completeAnnounceText: String = ""
    @Published var pendingAnnounceText: String = ""
    
    init(fetchTodayStudyUseCase: FetchTodayStudyUseCase) {
        self.fetchTodayStudyUseCase = fetchTodayStudyUseCase
    }
    
    @MainActor
    func fetchData() async {
        do {
            let todayStudyContent = try await fetchTodayStudyUseCase.execute(
                area: .todo,
                year: 2025, // TODO: 스프린트에서 변경 예정
                semester: .first, // TODO: 스프린트에서 변경 예정
                sortOption: .recent
            )
            todayCount = todayStudyContent.todayCount
            completeCount = todayStudyContent.completeCount
            pendingCount = todayStudyContent.pendingCount
            todoPiecesList = todayStudyContent.todoPiecesList
            completeAnnounceText = todayStudyContent.completeAnnounceText
            pendingAnnounceText = todayStudyContent.pendingAnnounceText
        } catch {
            dump(error)
        }
    }
}
