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
    
    init(viewModel: SubjectDetailViewModel) {
        _viewModel = StateObject(wrappedValue: viewModel)
    }
    
    var body: some View {
        VStack(spacing: 0) {
            CustomNavigationBar(
                showBackButton: true,
                showMenu: true,
                title: "경제통계학",
                backgroundColor: Color(.backgroundAccent)
            )
            
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
        HStack(spacing: 16) {
            CustomText(
                "학습 내용",
                fontType: .headline2Bold,
                color: Color(.labelAlternative)
            )
            
            Spacer()
            
            Button {
                viewModel.deleteStudyPiece()
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
    
    var studyPieceList: some View {
        VStack(spacing: 16) {
            ForEach(
                $viewModel.modelList,
                id: \.self
            ) { $model in
                Button {
                
                } label: {
                    StudyCard(
                        state: model.state,
                        studyCardData: model
                    )
                }
                .buttonStyle(PressedButtonStyle())
                .customShadow(.normal)
            }
        }
    }
}
