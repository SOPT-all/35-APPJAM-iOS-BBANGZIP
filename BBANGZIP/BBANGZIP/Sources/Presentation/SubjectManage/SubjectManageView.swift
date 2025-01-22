//
//  StudyManageView.swift
//  BBANGZIP
//
//  Created by 최유빈 on 1/18/25.
//  Copyright © 2025 com.bbangzip. All rights reserved.
//

import SwiftUI

struct SubjectManageView: View {
    @StateObject private var viewModel: SubjectManageViewModel
    private let selectedBottomSheetType: BottomSheetType?
    @Binding var isBottomSheetShowing: Bool
    @Binding var isCustomTabBarHidden: Bool
    
    init(
        // TODO: dataCount API 연동 후 수정 필요
        viewModel: SubjectManageViewModel = SubjectManageViewModel(modelList: []),
        selectedBottomSheetType: BottomSheetType? = .changeSemester,
        isBottomSheetShowing: Binding<Bool>,
        isCustomTabBarHidden: Binding<Bool>
    ) {
        _viewModel = StateObject(wrappedValue: viewModel)
        self.selectedBottomSheetType = selectedBottomSheetType
        _isBottomSheetShowing = isBottomSheetShowing
        _isCustomTabBarHidden = isCustomTabBarHidden
    }
    
    private let columns = [
        GridItem(
            .flexible(),
            spacing: 20
        ),
        GridItem(.flexible())
    ]
    
    var body: some View {
        ScrollView {
            VStack {
                HStack {
                    ChangeSemesterButton(viewModel: viewModel)
                        .padding(
                            .leading,
                            24
                        )
                    
                    Spacer()
                }
                .padding(
                    .top,
                    55
                )
                .padding(
                    .bottom,
                    169
                )
                .background(
                    Color(.backgroundAccent)
                        .cornerRadius(
                            32,
                            corners: [
                                .bottomLeft,
                                .bottomRight
                            ]
                        )
                )
                
                VStack(spacing: 32) {
                    subjectSection
                    
                    subjectCardScrollSection
                }
                .padding(
                    .top,
                    48
                )
                .padding(
                    .horizontal,
                    20
                )
                
                Spacer()
            }
            .bottomSheet(
                isShowing: $viewModel.isShowingBottomSheet,
                height: 453
            ) {
                if let type = selectedBottomSheetType {
                    type.contentView(isPresented: $viewModel.isShowingBottomSheet)
                }
            }
            .onChange(of: viewModel.isShowingBottomSheet) { newValue in
                isBottomSheetShowing = newValue
            }
            .onAppear {
                viewModel.fetchSubjectData()
            }
        }
        .edgesIgnoringSafeArea(.top)
        .scrollIndicators(.hidden)
        
    }
    
    var subjectSection: some View {
        HStack {
            CustomText(
                "어떤 과목을 공부해 볼까요?",
                fontType: .headline2Bold,
                color: Color(.labelAlternative)
            )
            
            Spacer()
            
            Button {
                viewModel.deleteSubject()
            } label: {
                Image(.trash)
                    .renderingMode(.template)
                    .resizable()
                    .scaledToFit()
                    .frame(
                        width: 24,
                        height: 24
                    )
                    .foregroundStyle(Color(.labelAssistive))
            }
        }
    }
    
    var subjectCardScrollSection: some View {
        LazyVGrid(
            columns: columns,
            spacing: 20
        ) {
            ForEach(
                $viewModel.modelList,
                id: \.self
            ) {
                $model in
//                Button {
//                    model.state = model.state == .cardDefault ? .cardDefault : model.state == .selectable ? .selected : .selectable
//                } label: {
//                    SubjectCard(
//                        state: model.state,
//                        subjectCardData: model
//                    )
//                }
//                .buttonStyle(PressedButtonStyle())
                
                NavigationLink(destination: SubjectDetailView(viewModel: SubjectDetailViewModel(modelList: StudyPieceModel.mockList), isBottomSheetShowing: $isBottomSheetShowing)
                    .onAppear { isCustomTabBarHidden = true }
                    .onDisappear { isCustomTabBarHidden = false }
                ) {
                    SubjectCard(
                        state: model.state,
                        subjectCardData: model
                    )
                }
                .buttonStyle(PressedButtonStyle())
            }
            
            Button {
                // TODO: 추가 페이지 이동
            } label: {
                SubjectAddCard()
            }
            .buttonStyle(PressedButtonStyle())
        }
        .padding(
            .bottom,
            76
        )
    }
}
