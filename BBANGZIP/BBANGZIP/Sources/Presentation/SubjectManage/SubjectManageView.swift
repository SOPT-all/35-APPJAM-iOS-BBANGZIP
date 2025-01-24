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
        viewModel: SubjectManageViewModel,
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
        if viewModel.isLoading {
            ProgressView()
                .navigationBarHidden(true)
                .onAppear {
                    Task { @MainActor in
                        await viewModel.fetchData()
                    }
                }
        } else {
            ZStack {
                ScrollView {
                    VStack {
                        HStack {
                            ChangeSemesterButton()
                                .padding(
                                    .leading,
                                    24
                                )
                            
                            Spacer()
                        }
                        .padding(
                            .top,
                            63
                        )
                        .padding(
                            .bottom,
                            169
                        )
                        .background(
                            ZStack {
                                Color(.backgroundAccent)
                                    .cornerRadius(
                                        32,
                                        corners: [
                                            .bottomLeft,
                                            .bottomRight
                                        ]
                                    )
                                
                                Image(.graphicStudyManage)
                                    .padding(.top, 47)
                            }
                        )
                        
                        if viewModel.modelList.isEmpty {
                            emptyView
                        } else {
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
                        }
                        
                        if viewModel.isDeleteMode {
                            Spacer()
                                .frame(height: 56)
                        }
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
                        viewModel.isDeleteMode = false
                        isCustomTabBarHidden = false
                        Task { @MainActor in
                            await viewModel.fetchData()
                        }
                    }
                }
                .edgesIgnoringSafeArea(.top)
                .scrollIndicators(.hidden)
                .toastView(toast: $viewModel.toast)
                
                VStack {
                    Spacer()
                    
                    if viewModel.isDeleteMode && viewModel.selectedItemCount > 0 {
                        deleteButton
                    }
                }
            }
        }
    }
    
    var subjectSection: some View {
        if viewModel.isDeleteMode {
            HStack {
                CustomText(
                    "삭제할 과목을 선택해 주세요",
                    fontType: .headline2Bold,
                    color: Color(.labelAlternative)
                )
                
                Spacer()
                
                Button {
                    viewModel.makeSelectableSubject()
                } label: {
                    Image(.xSmall)
                        .renderingMode(.template)
                        .resizable()
                        .frame(
                            width: 24,
                            height: 24
                        )
                        .foregroundStyle(Color(.labelAssistive))
                }
            }
        } else {
            HStack(spacing: 16) {
                CustomText(
                    "어떤 과목을 공부해 볼까요?",
                    fontType: .headline2Bold,
                    color: Color(.labelAlternative)
                )
                
                Spacer()
                
                Button {
                    viewModel.makeSelectableSubject()
                } label: {
                    Image(.trash)
                        .renderingMode(.template)
                        .resizable()
                        .frame(
                            width: 24,
                            height: 24
                        )
                        .foregroundStyle(Color(.labelAlternative))
                }
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
                Button {
                    if viewModel.isDeleteMode {
                        if model.state == .selectable {
                            model.state = .selected
                            viewModel.toggleSelection(subjectId: model.subjectId) 
                        } else if model.state == .selected {
                            model.state = .selectable
                            viewModel.toggleSelection(subjectId: model.subjectId)
                        }
                    } else {
                        model.state = .cardDefault
                    }
                    viewModel.validateDeleteButton()
                } label: {
                    if model.state == .cardDefault {
                        NavigationLink(
                            destination: SubjectDetailView(
                                viewModel: SubjectDetailViewModel(
                                    filterExamUseCase: DefaultFilterExamUseCase(examRepository: DefaultExamRepository()),
                                    deleteStudyPieceUseCase: DefaultDeleteStudyPieceUseCase(
                                        repository: DefaultExamRepository()
                                    ),
                                    completeTodayStudyUseCase: DefaultCompleteTodayStudyUseCase(
                                        repository: DefaultStudyRepository()
                                    ),
                                    revertCompleteTodayStudyUseCase: DefaultRevertCompleteTodayStudyUseCase(
                                        repository: DefaultStudyRepository()
                                    ),
                                    subjectId: model.subjectId
                                ),
                                isBottomSheetShowing: $isBottomSheetShowing
                            )
                            .onAppear { isCustomTabBarHidden = true
                            }
                        ) {
                            SubjectCard(
                                state: model.state,
                                subjectCardData: model
                            )
                        }
                        .buttonStyle(PressedButtonStyle())
                    } else {
                        SubjectCard(
                            state: model.state,
                            subjectCardData: model
                        )
                    }
                }
                .buttonStyle(PressedButtonStyle())
                .customShadow(.normal)
            }
            
            if !viewModel.isDeleteMode {
                NavigationLink(
                    destination: AddSubjectView(
                        viewModel: AddSubjectViewModel(
                            addSubjectUseCase: DefaultAddSubjectUseCase(
                                repository: DefaultSubjectRepository()
                            ),
                            parentViewModel: viewModel
                        )
                    )
                        .onAppear {
                            isCustomTabBarHidden = true
                        }
                )
                {
                    SubjectAddCard()
                }
                .buttonStyle(PressedButtonStyle())
            }
        }
        .padding(
            .bottom,
            76
        )
    }
    
    var deleteButton: some View {
        let title = "\(viewModel.selectedItemCount)개 삭제하기"
        
        return VStack {
            Spacer()
            
            Button(title) {
                Task {
                    await viewModel.deleteSubject() 
                }
            }
            .buttonStyle(
                SolidIconButton(
                    buttonImage: Image(.trash)
                )
            )
            .padding(
                .horizontal,
                20
            )
            .padding(
                .bottom,
                68
            )
        }
    }
    
    var emptyView: some View {
        VStack(spacing: 16) {
            Image(.graphicEmptySubject)
                .frame(
                    width: 320,
                    height: 296
                )
            
            NavigationLink (
                destination: AddSubjectView(
                    viewModel: AddSubjectViewModel(
                        addSubjectUseCase: DefaultAddSubjectUseCase(repository: DefaultSubjectRepository()),
                        parentViewModel: viewModel
                    )
                )
                .onAppear {
                    isCustomTabBarHidden = true
                }
            ){
                CustomText(
                    "과목 추가하기",
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
        }
    }
}
