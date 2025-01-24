//
//  AddTodayStudyViewModel.swift
//  BBANGZIP
//
//  Created by 조성민 on 1/23/25.
//  Copyright © 2025 com.bbangzip. All rights reserved.
//

import SwiftUI

final class AddTodayStudyViewModel: ObservableObject {
    @Published var isLoading: Bool = true
    @Published var sortOption: FetchTodayStudySortOption = .recent
    @Published var studyCount: Int = 0
    @Published var selectedCount: Int = 0
    @Published var list: [StudyPiece] = []
    @Published var isFilterBottomSheetPresent: Bool = false
    var toast: Toast?
    
    private let fetchAddTodayStudyUseCase: FetchAddTodayStudyUseCase
    
    init(fetchAddTodayStudyUseCase: FetchAddTodayStudyUseCase) {
        self.fetchAddTodayStudyUseCase = fetchAddTodayStudyUseCase
    }
    
    @MainActor
    func fetchData() async {
        do {
            let result = try await fetchAddTodayStudyUseCase.execute(
                year: 2025,
                semester: .first,
                sortOption: sortOption
            )
            studyCount = result.count
            list = result.list
            selectedCount = 0
            isLoading = false
        } catch {
            isLoading = false
            dump(error)
        }
    }
}
