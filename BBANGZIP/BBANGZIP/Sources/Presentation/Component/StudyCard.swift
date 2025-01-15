//
//  StudyCard.swift
//  BBANGZIP
//
//  Created by 최유빈 on 1/15/25.
//  Copyright © 2025 com.bbangzip. All rights reserved.
//

import SwiftUI

struct StudyCard: View {
    var body: some View {
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
            Spacer()
            
            CheckBox(isChecked: false)
                .padding(.bottom, 50)
        }
        .padding(.vertical, 10)
        .padding(.horizontal, 16)
        .frame(maxWidth: .infinity)
        .overlay(RoundedRectangle(cornerRadius: 24)
            .stroke(BBANGZIPAsset.Assets.lineAlternative.swiftUIColor, lineWidth: 1))
    }
}

#Preview {
    Button {
        
    } label: {
        StudyCard()
    }
    .padding(.horizontal, 20)
    .buttonStyle(StudyCardButtonStyle())
}
