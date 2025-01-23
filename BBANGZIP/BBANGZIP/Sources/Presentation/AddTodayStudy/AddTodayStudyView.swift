//
//  AddTodayStudyView.swift
//  BBANGZIP
//
//  Created by 조성민 on 1/23/25.
//  Copyright © 2025 com.bbangzip. All rights reserved.
//

import SwiftUI

struct AddTodayStudyView: View {
    
    @StateObject private var viewModel: AddTodayStudyViewModel
    @SwiftUI.Environment(\.dismiss) private var dismiss
    
    init(viewModel: AddTodayStudyViewModel) {
        self._viewModel = StateObject(wrappedValue: viewModel)
//        UIScrollView.appearance().bounces = false
    }
    
    var body: some View {
        if viewModel.isLoading {
            ProgressView()
                .task {
                    await viewModel.fetchData()
                }
        } else {
            ScrollView {
                VStack(
                    alignment: .leading,
                    spacing: 0
                ) {
                    CustomText(
                        "시작이 빵이다!",
                        fontType: .body1Bold,
                        color: Color(.labelAlternative)
                    )
                    .padding(
                        .bottom,
                        8
                    )
                    
                    CustomText(
                        "오늘부터 하나씩!\n공부할 내용을 선택해 보세요",
                        fontType: .title3Bold,
                        color: Color(.labelNormal)
                    )
                    .padding(
                        .bottom,
                        32
                    )
                    
                    menuBar
                        .padding(
                            .bottom,
                            26
                        )
                    
                    listView
                    
                    Spacer()
                }
                .padding(
                    .top,
                    32
                )
                .padding(
                    .horizontal,
                    20
                )
            }
            .navigationBarBackButtonHidden()
            .toolbar {
                ToolbarItem(placement: .topBarLeading) {
                    Button {
                        dismiss()
                    } label: {
                        Image(.chevronLeftThickSmall)
                            .renderingMode(.template)
                            .foregroundStyle(Color(.labelAlternative))
                    }
                }
            }
        }
    }
    
    private var menuBar: some View {
        HStack(spacing: 0) {
            CustomText(
                "\(viewModel.selectedCount)",
                fontType: .body2Bold,
                color: Color(.labelNormal)
            )
            
            CustomText(
                "개 / 총 \(viewModel.studyCount)개",
                fontType: .label1Medium,
                color: Color(.labelAlternative)
            )
            
            Spacer()
            
            Button {
                print("Filter button Tapped")
            } label: {
                Image(.filter)
                    .renderingMode(.template)
                    .foregroundStyle(Color(.labelAlternative))
            }
            
        }
        .padding(
            .leading,
            8
        )
    }
    
    private var listView: some View {
        VStack(spacing: 12) {
            ForEach($viewModel.list) { $piece in
                Button {
                    if piece.state == .selectable {
                        piece.state = .selected
                        viewModel.selectedCount += 1
                    } else {
                        piece.state = .selectable
                        viewModel.selectedCount -= 1
                    }
                } label: {
                    StudyCard(model: piece)
                }
            }
        }
        .padding(
            .bottom,
            87
        )
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
