//
//  SubjectAddCard.swift
//  BBANGZIP
//
//  Created by 최유빈 on 1/19/25.
//  Copyright © 2025 com.bbangzip. All rights reserved.
//

import SwiftUI

struct SubjectAddCard: View {
    // TODO: API 연결 후 주입 값 형식 변경, 현재는 필요한 값을 struct로 묶어 주입하는 형식
    private let borderPadding: CGFloat = 3
    
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
        .padding(borderPadding)
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
