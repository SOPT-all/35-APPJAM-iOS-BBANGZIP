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
        VStack(spacing: 0) {
            CustomNavigationBar(
                showBackButton: true,
                showMenu: true,
                title: "경제통계학",
                backgroundColor: Color(.backgroundAccent)
            )
            
            ZStack {
                ScrollView {
                    ZStack {
                        VStack {
                            Color(.backgroundAccent)
                                .frame(height: 153)
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
                            )
                            .padding(
                                .top,
                                28
                            )
                            .padding(
                                .horizontal,
                                20
                            )
                            
                            HStack(spacing: 8) {
                                Chip(type: .daysLeftWithText(24))
                                
                                CustomText(
                                    "2025년 5월 13일",
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
                        }
                    }
                    .navigationBarHidden(true)
                }
                .bottomSheet(
                    isShowing: $viewModel.isShowingBottomSheet,
                    height: 265
                ) {
                    if let type = selectedBottomSheetType {
                        type.contentView(isPresented: $viewModel.isShowingBottomSheet)
                    }
                }
                
                if viewModel.isDeleteMode {
                    VStack {
                        Spacer()
                        Button("삭제하기") {
                            viewModel.deleteStudyPiece()
                        }
                        .buttonStyle(
                            SolidIconButton(
                                buttonImage: Image(.trash),
                                false
                            )
                        )
                        .padding(.horizontal, 20)
                        .padding(.bottom, 8)
                    }
                }

            }
        }
    }
    
    var backgroundView: some View {
        HStack {
            CustomText(
                "사장님의 각오 한 마디를 작성해 보세요",
                fontType: .heading2Bold,
                color: Color(.labelAssistive)
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
                id: \.pieceID
            ) { $model in
                Button {
                    if model.state == .cardDefault {
                        model.state = .complete
                        viewModel.completeStudyPiece()
                    } else if model.state == .complete {
                        if viewModel.isDeleteMode {
                            // TODO: Toast Present
                            print("Toast Present")
                        } else {
                            viewModel.checkCompleteOrNot()
                        }
                    } else if model.state == .selectable {
                        model.state = .selected
                    } else {
                        model.state = .selectable
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
        }
    }
}
