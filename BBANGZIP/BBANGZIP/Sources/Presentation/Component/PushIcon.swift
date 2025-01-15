//
//  PushIcon.swift
//  BBANGZIP
//
//  Created by 송여경 on 1/15/25.
//  Copyright © 2025 com.bbangzip. All rights reserved.
//

import SwiftUI

struct PushIcon: View {
    enum IconType {
        case black
        case yellow
        case orange
        
        var color: Color {
            switch self {
            case .black:
                return BBANGZIPAsset.Assets.statusPositive.swiftUIColor
            case .yellow:
                return BBANGZIPAsset.Assets.statusCautionary.swiftUIColor
            case .orange:
                return BBANGZIPAsset.Assets.statusDestructive.swiftUIColor
            }
        }
    }
    let number: Int
    let type: IconType
    
    var body: some View {
        Circle()
            .fill(type.color)
            .frame(width: 20, height: 20)
            .overlay(
                Text("\(number)")
                    .font(BbangFont.caption2.swiftUIFont)
                    .foregroundColor(BBANGZIPAsset.Assets.staticWhite.swiftUIColor)
            )
    }
}

#Preview {
    VStack(spacing: 10) {
        PushIcon(number: 1, type: .black)
        PushIcon(number: 2, type: .yellow)
        PushIcon(number: 6, type: .orange)
    }
}
