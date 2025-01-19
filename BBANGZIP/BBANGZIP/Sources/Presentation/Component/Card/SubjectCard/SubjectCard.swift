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
    private let subjectCardData: SubjectCardData
    
    init(
        state: CardState,
        subjectCardData: SubjectCardData
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
                        subjectCardData.title,
                        fontType: .body1Bold,
                        color: Color(.labelNormal)
                    )
                    
                    CustomText(
                        subjectCardData.test,
                        fontType: .label2Bold,
                        color: Color(.labelNeutral)
                    )
                    
                    Chip(type: subjectCardData.chipType)
                    
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
        .frame(
            height: 190
        )
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
                number: subjectCardData.delayedStudyCount,
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
                number: subjectCardData.inProgressStudyCount,
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
