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
        ZStack {
            backgroundView
            
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
        }
        .frame(height: 190)
        .padding(2)
    }
    
    private var backgroundView: some View {
        RoundedRectangle(cornerRadius: 24)
            .fill(Color(.backgroundNormal))
            .overlay(
                RoundedRectangle(cornerRadius: 24)
                    .stroke(
                        Color(.lineAlternative),
                        lineWidth: 1
                    )
            )
    }
}
