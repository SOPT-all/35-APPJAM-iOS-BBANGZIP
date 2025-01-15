//
//  StudyCard.swift
//  BBANGZIP
//
//  Created by 최유빈 on 1/15/25.
//  Copyright © 2025 com.bbangzip. All rights reserved.
//

import SwiftUI

enum Process {
    case Select
    case Check
}

struct StudyCard: View {
    private let process: Process
    @State var isCompleted = false
    @State var isSelected = false
    
    init(process: Process) {
        self.process = process
    }
    
    var body: some View {
        Button {
            switch process {
            case .Select:
                isSelected.toggle()
            case .Check:
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
                        BbangText (
                            "D-14",
                            fontType: .caption1,
                            color: Color(BBANGZIPAsset.Assets.staticWhite.color)
                        )
                        .padding(.vertical, 2)
                        .padding(.horizontal, 12)
                        .background(Capsule()
                            .fill(Color(BBANGZIPAsset.Assets.labelAlternative.color)))
                        
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
        .buttonStyle(StudyCardButtonStyle(isSelected: $isSelected))
        .frame(maxWidth: .infinity)
    }
}

#Preview {
    VStack {
        StudyCard(process: .Select)
            .padding(.horizontal, 20)
        
        StudyCard(process: .Check)
            .padding(.horizontal, 20)
        
        Spacer()
    }
}
