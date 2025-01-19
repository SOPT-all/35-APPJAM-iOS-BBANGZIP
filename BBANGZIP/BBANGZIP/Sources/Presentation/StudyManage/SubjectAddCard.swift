//
//  SubjectAddCard.swift
//  BBANGZIP
//
//  Created by 최유빈 on 1/19/25.
//  Copyright © 2025 com.bbangzip. All rights reserved.
//

import SwiftUI

struct SubjectAddCard: View {
    
    var body: some View {
        VStack(spacing: 8) {
            CircleIcon(name: "Plus")
                .padding(
                    .horizontal,
                    59
                )
            
            CustomText(
                "과목추가",
                fontType: .body1Bold,
                color: Color(.labelDisable)
            )
        }
        .padding(
            .vertical,
            59
        )
        .background(
            RoundedRectangle(cornerRadius: 24)
                .foregroundStyle(Color(.staticWhite))
                .overlay(
                    RoundedRectangle(cornerRadius: 24)
                        .stroke(
                            Color(.lineAlternative),
                            lineWidth: 2
                        )
                )
                .shadow(
                    color: Color(.staticBlack).opacity(0.25),
                    radius: 4,
                    y: 4
                )
        )
    }
}

#Preview {
    SubjectAddCard()
}
