//
//  Chip.swift
//  BBANGZIP
//
//  Created by 송여경 on 1/17/25.
//  Copyright © 2025 com.bbangzip. All rights reserved.
//

import SwiftUI

struct Chip: View {
    private let remainingDays: Int
    
    init(remainingDays: Int) {
        self.remainingDays = remainingDays
    }
    
    var body: some View {
        CustomText (
            "D - \(remainingDays)",
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
                .fill(Color(.labelAlternative)))
    }
}

#Preview {
    Chip(remainingDays: 10)
}
