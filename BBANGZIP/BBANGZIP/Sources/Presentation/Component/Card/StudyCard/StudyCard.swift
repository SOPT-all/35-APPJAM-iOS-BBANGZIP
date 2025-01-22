//
//  StudyCard.swift
//  BBANGZIP
//
//  Created by 최유빈 on 1/15/25.
//  Copyright © 2025 com.bbangzip. All rights reserved.
//

import SwiftUI

struct StudyCard: View {
    private let state: StudyCardState
    // TODO: 수정필요
    private let studyCardData: StudyPieceModel
    private let borderPadding: CGFloat = 2
    
    init(
        state: StudyCardState,
        studyCardData: StudyPieceModel = StudyPieceModel.mockList[0]
    ) {
        self.state = state
        self.studyCardData = studyCardData
    }
    
    var body: some View {
        ZStack {
            backgroundView
            
            HStack(alignment: .top) {
                StudyDataArea
                    .opacity(state == .complete ? 0.4 : 1)
                
                Spacer()
                
                CheckBox(state: state)
            }
            .padding(
                .vertical,
                10
            )
            .padding(
                .horizontal,
                16
            )
        }
    }
    
    var backgroundView: some View {
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
    
    var StudyDataArea: some View {
        VStack(
            alignment: .leading,
            spacing: 2
        ) {
            CustomText(
                studyCardData.studyContents,
                fontType: .caption1Medium,
                color: Color(.labelAlternative)
            )
            .padding(
                .leading,
                4
            )
            
            CustomText(
                "\(studyCardData.startPage)p - \(studyCardData.finishPage)",
                fontType: .label1Bold,
                color: Color(.labelNormal)
            )
            .padding(
                .top,
                2
            )
            .padding(
                .leading,
                4
            )
            
            HStack(spacing: 8) {
                Chip(
                    type: studyCardData.remainingDays >= 0 ? .delayedDate(studyCardData.remainingDays) : .daysLeftWithText(studyCardData.remainingDays)
                )
                CustomText(
                    "\(studyCardData.deadline) 까지",
                    fontType: .caption1Bold,
                    color: Color(.labelAlternative)
                )
            }
            .padding(
                .top,
                4
            )
        }
    }
}
