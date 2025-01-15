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
    
    func makeBody(configuration: Configuration) -> some View {
        if !isSelected {
            configuration
                .label
                .background(RoundedRectangle(cornerRadius: 24)
                    .fill(configuration.isPressed ? BBANGZIPAsset.Assets.backgroundAlternative.swiftUIColor : BBANGZIPAsset.Assets.backgroundNormal.swiftUIColor))
                .overlay(RoundedRectangle(cornerRadius: 24)
                    .stroke(BBANGZIPAsset.Assets.lineAlternative.swiftUIColor, lineWidth: 1))
        }
        else {
            configuration
                .label
                .background(RoundedRectangle(cornerRadius: 24)
                    .fill(BBANGZIPAsset.Assets.backgroundAlternative.swiftUIColor))
                .overlay(RoundedRectangle(cornerRadius: 24)
                    .stroke(BBANGZIPAsset.Assets.lineStrong.swiftUIColor, lineWidth: 3))
        }
    }
}

struct CompleteStudyCardButtonStyle: ButtonStyle {
    @Binding var isCompleted: Bool
    
    func makeBody(configuration: Configuration) -> some View {
        if isCompleted {
            configuration
                .label
                .background(RoundedRectangle(cornerRadius: 24)
                    .fill(configuration.isPressed ? BBANGZIPAsset.Assets.backgroundAlternative.swiftUIColor : BBANGZIPAsset.Assets.backgroundNormal.swiftUIColor))
                .overlay(RoundedRectangle(cornerRadius: 24)
                    .stroke(BBANGZIPAsset.Assets.lineAlternative.swiftUIColor, lineWidth: 1))
        }
        else {
            configuration
                .label
                .background(RoundedRectangle(cornerRadius: 24)
                    .fill(configuration.isPressed ? BBANGZIPAsset.Assets.backgroundAlternative.swiftUIColor : BBANGZIPAsset.Assets.backgroundNormal.swiftUIColor))
                .overlay(RoundedRectangle(cornerRadius: 24)
                    .stroke(BBANGZIPAsset.Assets.lineStrong.swiftUIColor, lineWidth: 3))
        }
    }
}
