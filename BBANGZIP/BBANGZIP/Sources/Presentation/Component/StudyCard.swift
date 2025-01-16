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
    let state: ButtonState
    
    init(state: ButtonState) {
        self.state = state
    }
    
    var body: some View {
        Button {
            switch state {
            case .base: break
            case .selectable:
                isSelected.toggle()
            case .isCompleted:
                isCompleted.toggle()
            }
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
        .buttonStyle(StudyCardButtonStyle(isSelected: $isSelected, state: state))
        .frame(maxWidth: .infinity)
    }
}

#Preview {
    VStack {
        let state: ButtonState
        
        StudyCard(state: .base)
            .padding(.horizontal, 20)
        
        StudyCard(state: .isCompleted)
            .padding(.horizontal, 20)
        
        StudyCard(state: .selectable)
            .padding(.horizontal, 20)
        
        Spacer()
    }
}
