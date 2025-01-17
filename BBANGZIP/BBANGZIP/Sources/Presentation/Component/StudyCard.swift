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
    @State private var isCompleted: Bool
    @State private var isSelected: Bool
    private let modifiable: Bool
    private let isManage: Bool
    
    init(
        isCompleted: Bool = false,
        isSelected: Bool = false,
        modifiable: Bool,
        isManage: Bool = true
    ) {
        self.isCompleted = isCompleted
        self.isSelected = isSelected
        self.modifiable = modifiable
        self.isManage = isManage
    }
    
    var body: some View {
        Button {
            modifiable ? isSelected.toggle() : isCompleted.toggle()
        } label: {
            HStack(alignment: .top) {
                StudyDataArea
                    .opacity(isCompleted ? 0.4 : 1)
                
                Spacer()
                
                CheckBox(isCompleted: isCompleted)
            }
            .padding(.vertical, 10)
            .padding(.horizontal, 16)
        }
        .buttonStyle(
            StudyCardButtonStyle(
                isSelected: isSelected,
                modifiable: modifiable
            )
        )
        .frame(maxWidth: .infinity)
    }
    
    var StudyDataArea: some View {
        VStack(alignment: .leading, spacing: 2) {
            if !isManage {
                CustomText(
                    "\(studyData.subjectName) / \(studyData.examName)",
                    fontType: .caption2Medium,
                    color: Color(.labelAssistive)
                )
                .padding(.leading, 4)
            }
            
            CustomText(
                studyData.studyContents,
                fontType: .caption1Medium,
                color: Color(.labelAlternative)
            )
            .padding(.leading, 4)
            
            CustomText(
                "\(studyData.startPage)p - \(studyData.finishPage)",
                fontType: .label1Bold,
                color: Color(.labelNormal)
            )
            .padding(.top, 2)
            .padding(.leading, 4)
            
            HStack(spacing: 8) {
                Chip(remainingDays: studyData.remainingDays)
                
                CustomText(
                    "\(studyData.deadline) 까지",
                    fontType: .caption1Bold,
                    color: Color(.labelAlternative)
                )
            }
            .padding(.top, 4)
        }
    }
}

