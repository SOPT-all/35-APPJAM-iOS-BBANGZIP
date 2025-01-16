//
//  StudyCard.swift
//  BBANGZIP
//
//  Created by 최유빈 on 1/15/25.
//  Copyright © 2025 com.bbangzip. All rights reserved.
//

import SwiftUI

struct StudyCard: View {
    private let studyData = SampleStudyData.sampleStudy
    @State var isCompleted = false
    @State var isSelected = false
    @Binding var modifiable: Bool
    
    var body: some View {
        Button {
            modifiable ? isSelected.toggle() : isCompleted.toggle()
        } label: {
            HStack {
                VStack(alignment: .leading, spacing: 2) {
                    BbangText(
                        "\(studyData.subjectName) / \(studyData.examName)",
                        fontType: .caption2,
                        color: Color(BBANGZIPAsset.Assets.labelAssistive.color)
                    )
                    .padding(.leading, 4)
                    
                    BbangText(
                        studyData.studyContents,
                        fontType: .caption1,
                        color: Color(BBANGZIPAsset.Assets.labelAlternative.color)
                    )
                    .padding(.leading, 4)
                    
                    BbangText(
                        "\(studyData.startPage)p - \(studyData.finishPage)",
                        fontType: .label1,
                        color: Color(BBANGZIPAsset.Assets.labelNormal.color)
                    )
                    .padding(.top, 2)
                    .padding(.leading, 4)
                    
                    HStack(spacing: 8) {
                        Chip(remainingDays: studyData.remainingDays)
                        
                        BbangText (
                            "\(studyData.deadline) 까지",
                            fontType: .caption1,
                            color: Color(BBANGZIPAsset.Assets.labelAlternative.color)
                        )
                    }
                    .padding(.top, 4)
                }
                .opacity(isCompleted ? 0.4 : 1)
                
                Spacer()
                
                CheckBox(isCompleted: isCompleted)
                    .padding(.bottom, 50)
            }
            .padding(.vertical, 10)
            .padding(.horizontal, 16)
        }
        .buttonStyle(StudyCardButtonStyle(isSelected: $isSelected, modifiable: $modifiable))
        .frame(maxWidth: .infinity)
    }
}
