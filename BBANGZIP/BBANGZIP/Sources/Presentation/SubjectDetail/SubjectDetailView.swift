//
//  SubjectDetailView.swift
//  BBANGZIP
//
//  Created by 최유빈 on 1/21/25.
//  Copyright © 2025 com.bbangzip. All rights reserved.
//

import SwiftUI

struct SubjectDetailView: View {
    @StateObject private var viewModel: SubjectDetailViewModel
    @Binding var isBottomSheetShowing: Bool
    private let selectedBottomSheetType: BottomSheetType?
    
    init(
        viewModel: SubjectDetailViewModel,
        isBottomSheetShowing: Binding<Bool>
    ) {
        _viewModel = StateObject(wrappedValue: viewModel)
        _isBottomSheetShowing = isBottomSheetShowing
        self.selectedBottomSheetType = .completeCheck
    }
    
    var body: some View {
        ZStack {
            if viewModel.isLoading {
                ProgressView()
                    .navigationBarHidden(true)
            } else {
                VStack(spacing: 0) {
                    CustomNavigationBar(
                        showBackButton: true,
                        showMenu: true,
                        title: viewModel.subjectName,
                        backgroundColor: Color(.backgroundAccent)
                    )
                    .environmentObject(viewModel)
                    
                    ZStack {
                        ScrollView {
                            ZStack {
                                VStack {
                                    Color(.backgroundAccent)
                                        .frame(
                                            height: 153
                                        )
                                        .cornerRadius(
                                            32,
                                            corners: [
                                                .bottomLeft,
                                                .bottomRight
                                            ]
                                        )
                                        .ignoresSafeArea(
                                            .all,
                                            edges: .top
                                        )
                                    
                                    Spacer()
                                }
                                
                                
                                VStack(spacing: 16) {
                                    backgroundView
                                        .padding(
                                            .top,
                                            25
                                        )
                                    
                                    MenuTab(
                                        tabNames: [
                                            "중간고사",
                                            "기말고사"
                                        ]
                                    ) { selectedTab in
                                        Task {
                                            await viewModel.updateExam(selectedTab)
                                        }
                                    }
                                    .padding(
                                        .top,
                                        28
                                    )
                                    .padding(
                                        .horizontal,
                                        20
                                    )
                                    
                                    if viewModel.modelList.isEmpty {
                                        emptyView
                                    } else {
                                        HStack(spacing: 8) {
                                            Chip(type: viewModel.examChipType)
                                            
                                            CustomText(
                                                viewModel.examDate.toKoreanDateFormat(),
                                                fontType: .label1Bold,
                                                color: Color(.labelAlternative)
                                            )
                                        }
                                        
                                        studyListHeaderView
                                            .padding(
                                                .top,
                                                32
                                            )
                                            .padding(
                                                .horizontal,
                                                20
                                            )
                                        
                                        studyPieceList
                                            .padding(
                                                .horizontal,
                                                20
                                            )
                                            .padding(
                                                .bottom,
                                                16
                                            )
                                    }
                                    
                                    if viewModel.isDeleteMode {
                                        Spacer()
                                            .frame(height: 56)
                                    }
                                }
                            }
                            .navigationBarHidden(true)
                        }
                        .scrollIndicators(.hidden)
                        
                        if viewModel.isDeleteMode && viewModel.selectedItemCount > 0 {
                            deleteButton
                        }
                    }
                }
            }
            if viewModel.isShowingBottomSheet {
                revertBottomSheet
            }
        }
        .onAppear {
            Task {
                await viewModel.fetchData()
            }
        }
        .toastView(toast: $viewModel.toast)
    }
    
    var backgroundView: some View {
        HStack {
            CustomText(
                viewModel.motivationMessage.isEmpty ? "사장님의 각오 한 마디를 작성해 보세요" : viewModel.motivationMessage,
                fontType: .heading2Bold,
                color: viewModel.motivationMessage.isEmpty ? Color(.labelAssistive) : Color(.labelNeutral)
            )
            .lineLimit(2)
            .padding(
                .leading,
                24
            )
            .padding(
                .trailing,
                151
            )
            .frame(height: 56)
            
            Spacer()
        }
    }
    
    var studyListHeaderView: some View {
        Group {
            if viewModel.isDeleteMode {
                HStack(spacing: 16) {
                    CustomText(
                        "삭제할 항목을 눌러서 선택해 주세요",
                        fontType: .headline2Bold,
                        color: Color(.labelAlternative)
                    )
                    
                    Spacer()
                    
                    Button {
                        viewModel.makeStudyPieceSelectable()
                    } label: {
                        Image(.xSmall)
                            .renderingMode(.template)
                            .resizable()
                            .frame(
                                width: 24,
                                height: 24
                            )
                            .foregroundStyle(Color(.labelAlternative))
                    }
                }
            } else {
                HStack(spacing: 16) {
                    CustomText(
                        "학습 내용",
                        fontType: .headline2Bold,
                        color: Color(.labelAlternative)
                    )
                    
                    Spacer()
                    
                    Button {
                        viewModel.makeStudyPieceSelectable()
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
                    
                    Button {
                        
                    } label: {
                        Image(.plus)
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
    }
    
    var studyPieceList: some View {
        VStack(spacing: 16) {
            ForEach(
                $viewModel.modelList,
                id: \.pieceId
            ) { $model in
                Button {
                    if viewModel.isDeleteMode {
                        if model.state == .selectable {
                            model.state = .selected
                            viewModel.toggleSelection(pieceId: model.pieceId)
                        } else if model.state == .selected {
                            model.state = .selectable
                            viewModel.toggleSelection(pieceId: model.pieceId)  
                        }
                    } else {
                        if model.state == .cardDefault {
                            model.state = .complete
                            Task {
                                await viewModel.completeStudy(pieceID: model.pieceId)
                            }
                        } else if model.state == .complete {
                            if viewModel.isDeleteMode {
                                print("Toast Present")
                            } else {
                                viewModel.revertTargetPieceID = model.pieceId
                                viewModel.isShowingBottomSheet = true
                            }
                        }
                    }
                    viewModel.validateDeleteButton()
                } label: {
                    StudyPieceCard(
                        state: model.state,
                        StudyPieceCardData: model
                    )
                }
                .buttonStyle(PressedButtonStyle())
                .customShadow(.normal)
            }
            
            // TODO: 공부 추가 화면으로 이동
            if !viewModel.isDeleteMode {
                NavigationLink(destination: Text("공부추가")){
                    AddStudyCard()
                }
                .buttonStyle(PressedButtonStyle())
            }
        }
    }
    
    var deleteButton: some View {
        let title = "\(viewModel.selectedItemCount)개 삭제하기"
        
        return VStack {
            Spacer()
            
            Button(title) {
                Task {
                    await viewModel.deleteStudyPiece()
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
                8
            )
        }
    }
    
    var emptyView: some View {
        VStack(spacing: 16) {
            Image(.graphicEmptyStudy)
                .frame(
                    width: 320,
                    height: 296
                )
            
            NavigationLink (destination: AddStudyView()){
                CustomText(
                    "공부할 내용 추가하기",
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
    
    private var revertBottomSheet: some View {
        BottomSheet(
            isShowing: $viewModel.isShowingBottomSheet,
            height: 265
        ) {
            VStack(spacing: 0) {
                CustomText(
                    "미완료 상태로 되돌릴까요?",
                    fontType: .headline1Bold,
                    color: Color(.labelNeutral)
                )
                .padding(
                    .top,
                    15
                )
                .padding(
                    .bottom,
                    31
                )
                
                Button {
                    Task {
                        await viewModel.revertStudyPiece()
                    }
                    viewModel.isShowingBottomSheet = false
                    viewModel.toast = Toast(
                        "미완료 상태로 되돌렸어요!",
                        startFrom: 20
                    )
                } label: {
                    CustomText(
                        "되돌리기",
                        fontType: .body1Bold,
                        color: Color(.staticWhite)
                    )
                }
                .buttonStyle(SolidButton(true))
                .padding(
                    .bottom,
                    8
                )
                
                Button {
                    viewModel.isShowingBottomSheet = false
                } label: {
                    CustomText(
                        "취소",
                        fontType: .body1Bold,
                        color: Color(.primaryNormal)
                    )
                }
                .buttonStyle(OutlinedLargeButton())
            }
            .padding(
                .horizontal,
                20
            )
        }
        .onChange(of: viewModel.isShowingBottomSheet) { newValue in
            isBottomSheetShowing =   newValue
        }
    }
}
