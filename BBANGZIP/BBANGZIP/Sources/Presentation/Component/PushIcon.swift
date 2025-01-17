//
//  PushIcon.swift
//  BBANGZIP
//
//  Created by 송여경 on 1/15/25.
//  Copyright © 2025 com.bbangzip. All rights reserved.
//

import SwiftUI

struct PushIcon: View {
    private let number: Int
    private let type: IconType
    
    init(number: Int, type: IconType) {
        self.number = number
        self.type = type
    }
    
    var body: some View {
        Circle()
            .fill(type.color)
            .frame(width: 20, height: 20)
            .overlay(
                CustomText(
                    "\(number)",
                    fontType: .caption2Bold,
                    color: Color(.staticWhite)
                )
            )
    }
}

#Preview {
    VStack(spacing: 10) {
        PushIcon(
            number: 1,
            type: .black
        )
        PushIcon(
            number: 2,
            type: .yellow
        )
        PushIcon(
            number: 6,
            type: .orange
        )
    }
}
