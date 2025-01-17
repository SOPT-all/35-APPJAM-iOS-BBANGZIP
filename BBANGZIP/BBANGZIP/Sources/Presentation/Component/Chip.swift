//
//  Chip.swift
//  BBANGZIP
//
//  Created by 송여경 on 1/17/25.
//  Copyright © 2025 com.bbangzip. All rights reserved.
//
import SwiftUI

struct Chip: View {
    private let type: ChipType
    private let backgroundColor: Color
    
    init(
        type: ChipType,
        backgroundColor: Color
    ) {
        self.type = type
        self.backgroundColor = backgroundColor
    }
    
    var body: some View {
        CustomText(
            type.text,
            fontType: .caption1Medium,
            color: Color(.staticWhite)
        )
        .padding(.vertical, 2)
        .padding(.horizontal, 12)
        .background(
            Capsule()
                .fill(backgroundColor)
        )
    }
}

#Preview {
    VStack(spacing: 10) {
        Chip(
            type: .daysRemaining(
                24,
                withExamLabel: true
            ),
            backgroundColor: Color(
                .statusPositive
            )
        )
        Chip(
            type: .daysRemaining(
                -18,
                 withExamLabel: false
            ),
            backgroundColor: Color(.labelAlternative)
        )
        Chip(
            type: .daysRemaining(
                6,
                withExamLabel: false
            ),
            backgroundColor: Color(.statusDestructive)
        )
        Chip(
            type: .points(
                50
            ),
            backgroundColor: Color(
                .statusCautionary
            )
        )
        Chip(
            type: .level(1),
            backgroundColor: Color(.statusPositive)
        )
    }
    .padding()
}
