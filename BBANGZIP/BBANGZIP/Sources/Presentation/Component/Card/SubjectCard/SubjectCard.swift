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
            
            cardContent
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
                number: subjectCardData.studyList[0].pendingCount,
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
                number: subjectCardData.studyList[0].inProgressCount,
                type: .black
            )
            
            CustomText(
                "진행 중인 공부",
                fontType: .caption1Bold,
                color: Color(.labelAssistive)
            )
        }
    }
    
    var cardContent: some View {
        Group {
//            if subjectCardData.studyList.isEmpty {
//                emptyStateView
//            } else {
//                normalStateView
//            }
            emptyStateView
        }
    }

    var emptyStateView: some View {
        HStack {
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
                    "공부를 추가해주세요",
                    fontType: .label2Bold,
                    color: Color(.labelNeutral)
                )
                
                Spacer()
            }
            .padding(
                .vertical,
                16
            )
            .padding(
                .leading,
                16
            )
            
            Image(.chevronRightThickSmall)
                .renderingMode(.template)
                .resizable()
                .foregroundStyle(Color(.labelAssistive))
                .frame(width: 16, height: 16)
                .padding(
                    .trailing,
                    6
                )
        }
    }

    var normalStateView: some View {
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
                    subjectCardData.studyList[0].examName,
                    fontType: .label2Bold,
                    color: Color(.labelNeutral)
                )
                
                Chip(type: .daysLeftBlack(subjectCardData.studyList[0].examDDay))
                
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
            
            Image(.chevronRightThickSmall)
                .renderingMode(.template)
                .resizable()
                .foregroundStyle(Color(.labelAssistive))
                .frame(width: 16, height: 16)
                .padding(
                    .trailing,
                    6
                )
        }
    }
}
