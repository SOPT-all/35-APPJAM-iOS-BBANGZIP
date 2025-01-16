//
//  StudyCardButtonStyle.swift
//  BBANGZIP
//
//  Created by 최유빈 on 1/15/25.
//  Copyright © 2025 com.bbangzip. All rights reserved.
//

import SwiftUI

struct StudyCardButtonStyle: ButtonStyle {
    @Binding var isSelected: Bool
    @Binding var modifiable: Bool
    
    func makeBody(configuration: Configuration) -> some View {
        configuration
            .label
            .background(RoundedRectangle(cornerRadius: 24)
                .fill(backgroundColor(isPressed: configuration.isPressed)))
            .overlay(RoundedRectangle(cornerRadius: 24)
                .stroke(borderColor(), lineWidth: borderWidth()))
    }
    
    private func backgroundColor(isPressed: Bool) -> Color  {
        if modifiable {
            isPressed ? BBANGZIPAsset.Assets.labelNormal.swiftUIColor.opacity(0.12) : BBANGZIPAsset.Assets.backgroundAlternative.swiftUIColor
        }
        else {
            isPressed ? BBANGZIPAsset.Assets.labelNormal.swiftUIColor.opacity(0.12) : BBANGZIPAsset.Assets.backgroundNormal.swiftUIColor
        }
    }
    
    private func borderColor() -> Color {
        if modifiable {
            isSelected ? BBANGZIPAsset.Assets.lineStrong.swiftUIColor : BBANGZIPAsset.Assets.lineAlternative.swiftUIColor
        }
        else {
            BBANGZIPAsset.Assets.lineAlternative.swiftUIColor
        }
    }
    
    private func borderWidth() -> CGFloat {
        if modifiable {
            3
        }
        else {
            1
        }
    }
}
