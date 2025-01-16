//
//  StudyCard.swift
//  BBANGZIP
//
//  Created by 최유빈 on 1/15/25.
//  Copyright © 2025 com.bbangzip. All rights reserved.
//

import SwiftUI

struct StudyCard: View {
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
                        "과목이름 / 중간고사",
                        fontType: .caption2,
                        color: Color(BBANGZIPAsset.Assets.labelAssistive.color)
                    )
                    .padding(.leading, 4)
                    
                    BbangText(
                        "경제통계학",
                        fontType: .caption1,
                        color: Color(BBANGZIPAsset.Assets.labelAlternative.color)
                    )
                    .padding(.leading, 4)
                    
                    BbangText(
                        "540p - 540p",
                        fontType: .label1,
                        color: Color(BBANGZIPAsset.Assets.labelNormal.color)
                    )
                    .padding(.top, 2)
                    .padding(.leading, 4)
                    
                    HStack(spacing: 8) {
                        Chip()
                        
                        BbangText (
                            "2025년 11월 5일 까지",
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
