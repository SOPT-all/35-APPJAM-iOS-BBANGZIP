//
//  AddTodayStudyView.swift
//  BBANGZIP
//
//  Created by 조성민 on 1/23/25.
//  Copyright © 2025 com.bbangzip. All rights reserved.
//

import SwiftUI
//TodayStudyArea
struct AddTodayStudyView: View {
    
    @StateObject private var viewModel: AddTodayStudyViewModel
    
    init(viewModel: AddTodayStudyViewModel) {
        self._viewModel = StateObject(wrappedValue: viewModel)
    }
    
    var body: some View {
        if viewModel.isLoading {
            ProgressView()
                .task {
                    await viewModel.fetchData()
                }
        } else {
            Text("asdfasdf")
        }
    }
}

#Preview {
    AddTodayStudyView(
        viewModel: AddTodayStudyViewModel(
            fetchAddTodayStudyUseCase: DefaultFetchAddTodayStudyUseCase(
                repository: DefaultStudyRepository()
            )
        )
    )
}
