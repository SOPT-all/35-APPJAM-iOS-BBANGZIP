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

    init(type: ChipType) {
        self.type = type
    }

    var body: some View {
        CustomText(
            type.text,
            fontType: .caption1Medium,
            color: Color(.staticWhite)
        )
        .padding(
            .vertical,
            2
        )
        .padding(
            .horizontal,
            12
        )
        .background(
            Capsule()
                .fill(type.color)
        )
    }
}

#Preview {
    VStack(spacing: 10) {
        Chip(type: .daysLeftWithText(-24))
        Chip(type: .daysLeftGray(-18))
        Chip(type: .delayedDate(6))
        Chip(type: .points(50))
        Chip(type: .level(1))
    }
    .padding()
}
