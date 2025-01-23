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
    }
    
    var body: some View {
        if viewModel.isLoading {
            ProgressView()
                .task {
                    await viewModel.fetchData()
                }
        } else {
            ZStack {
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
                
                VStack {
                    Spacer()
                    
                    if viewModel.selectedCount > 0 {
                        Button {
                            print("aa")
                            // TODO: API 연결 -> 결과 오면 dismiss
                        } label: {
                            CustomText(
                                "오늘 할 공부 추가하기",
                                fontType: .body1Bold,
                                color: Color(.staticWhite)
                            )
                        }
                        .buttonStyle(
                            SolidIconButton(
                                buttonImage: Image(.plus)
                            )
                        )
                        .padding(
                            .horizontal,
                            20
                        )
                        .padding(
                            .bottom,
                            15
                        )
                    }
                }

            }
            .bottomSheet(
                isShowing: $viewModel.isFilterBottomSheetPresent,
                height: 225,
                content: {
                    VStack(spacing: 8) {
                        ForEach(
                            FetchTodayStudySortOption.allCases,
                            id: \.self
                        ) { filter in
                            Button {
                                viewModel.sortOption = filter
                                viewModel.isFilterBottomSheetPresent = false
                                Task {
                                    await viewModel.fetchData()
                                }
                                viewModel.toast = Toast(
                                    "\(filter.buttonTitle)으로 정렬했어요",
                                    startFrom: 76
                                )
                                //TODO: Toast
                            } label: {
                                HStack {
                                    Spacer()
                                    
                                    CustomText(
                                        filter.buttonTitle,
                                        fontType: .body1Bold,
                                        color: Color(.labelNeutral)
                                    )
                                    .frame(height: 40)
                                    
                                    Spacer()
                                }
                            }
                            .padding(
                                .horizontal,
                                20
                            )
                            .buttonStyle(PressedBottomSheetButtonStyle(isSelected: viewModel.sortOption == filter))
                        }
                    }
                    .padding(
                        .top,
                        24
                    )
                }
            )
            .toastView(toast: $viewModel.toast)
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
                viewModel.isFilterBottomSheetPresent = true
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
