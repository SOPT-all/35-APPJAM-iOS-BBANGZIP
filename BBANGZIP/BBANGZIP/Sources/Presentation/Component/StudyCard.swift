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
                
                BbangText(
                    "경제통계학",
                    fontType: .caption1,
                    color: Color(BBANGZIPAsset.Assets.labelAlternative.color)
                )
                
                BbangText(
                    "540p - 540p",
                    fontType: .label1,
                    color: Color(BBANGZIPAsset.Assets.labelNormal.color)
                )
                .padding(.top, 2)
                
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
        }
    }
}

#Preview {
    StudyCard()
}
