//
//  StudyPieceCard.swift
//  BBANGZIP
//
//  Created by 최유빈 on 1/22/25.
//  Copyright © 2025 com.bbangzip. All rights reserved.
//

import SwiftUI

struct StudyPieceCard: View {
    private let state: StudyPieceCardState
    // TODO: 수정필요
    private let StudyPieceCardData: StudyPieceModel
    private let borderPadding: CGFloat = 2
    
    init(
        state: StudyPieceCardState,
        StudyPieceCardData: StudyPieceModel = StudyPieceModel.mockList[0]
    ) {
        self.state = state
        self.StudyPieceCardData = StudyPieceCardData
    }
    
    var body: some View {
        ZStack {
            backgroundView
            
            HStack(alignment: .top) {
                StudyDataArea
                    .opacity(state == .complete ? 0.4 : 1)
                
                Spacer()
                
                StudyCheckBox(state: state)
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
            
//            CustomText(
//                "\(StudyPieceCardData.subjectName) / \(StudyPieceCardData.examName)",
//                fontType: .caption2Medium,
//                color: Color(.labelAssistive)
//            )
//            .padding(
//                .leading,
//                4
//            )
            
            
            CustomText(
                StudyPieceCardData.studyContents,
                fontType: .caption1Medium,
                color: Color(.labelAlternative)
            )
            .padding(
                .leading,
                4
            )
            
            CustomText(
                "\(StudyPieceCardData.startPage)p - \(StudyPieceCardData.finishPage)",
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
                    type: StudyPieceCardData.remainingDays >= 0 ? .delayedDate(StudyPieceCardData.remainingDays) : .daysLeftWithText(StudyPieceCardData.remainingDays)
                )
                CustomText(
                    "\(StudyPieceCardData.deadline) 까지",
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
