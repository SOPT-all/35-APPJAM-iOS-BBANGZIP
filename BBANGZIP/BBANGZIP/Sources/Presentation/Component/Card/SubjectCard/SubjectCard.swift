//
//  SubjectCard.swift
//  BBANGZIP
//
//  Created by 조성민 on 1/17/25.
//  Copyright © 2025 com.bbangzip. All rights reserved.
//

import SwiftUI

struct SubjectCard: View {
    private var state: CardState
    // TODO: API 연결 후 주입 값 형식 변경, 현재는 필요한 값을 struct로 묶어 주입하는 형식
    private let subjectCardData: SubjectCardModel
    private let borderPadding: CGFloat = 2
    
    init(
        state: CardState,
        subjectCardData: SubjectCardModel
    ) {
        self.state = state
        self.subjectCardData = subjectCardData
    }
    
    var body: some View {
        ZStack {
            backgroundView
            
            HStack(alignment: .center) {
                VStack(
                    alignment: .leading,
                    spacing: 4
                ) {
                    CustomText(
                        subjectCardData.subjectName,
                        fontType: .body1Bold,
                        color: Color(.labelNormal)
                    )
                    .lineLimit(1)
                    
                    CustomText(
                        subjectCardData.studyList.examName,
                        fontType: .label2Bold,
                        color: Color(.labelNeutral)
                    )
                    
                    Chip(type: .daysLeftBlack(-subjectCardData.studyList.examDday))
                    
                    Spacer()
                    
                    delayedStudyView
                    
                    inProgressStudyView
                }
                .padding(
                    .vertical,
                    16
                )
                .padding(
                    .leading,
                    16
                )
                
                Spacer()
                
                Image(.chevronRight)
                    .renderingMode(.template)
                    .foregroundStyle(Color(.labelAssistive))
                    .padding(
                        .trailing,
                        6
                    )
            }
        }
        .frame(height: 190)
        .padding(borderPadding)
    }
    
    private var backgroundView: some View {
        RoundedRectangle(cornerRadius: 24)
            .fill(state.backgroundColor)
            .overlay(
                RoundedRectangle(cornerRadius: 24)
                    .stroke(
                        state.borderColor,
                        lineWidth: state.borderWidth
                    )
            )
    }
    
    private var delayedStudyView: some View {
        HStack(spacing: 4) {
            PushIcon(
                number: subjectCardData.studyList.pendingCount,
                type: .orange
            )
            
            CustomText(
                "밀린 공부",
                fontType: .caption1Bold,
                color: Color(.labelAssistive)
            )
        }
    }
    
    private var inProgressStudyView: some View {
        HStack(spacing: 4) {
            PushIcon(
                number: subjectCardData.studyList.inProgressCount,
                type: .black
            )
            
            CustomText(
                "진행 중인 공부",
                fontType: .caption1Bold,
                color: Color(.labelAssistive)
            )
        }
    }
}
