//
//  StudyCardButtonStyle.swift
//  BBANGZIP
//
//  Created by 최유빈 on 1/15/25.
//  Copyright © 2025 com.bbangzip. All rights reserved.
//

import SwiftUI

struct StudyCardButtonStyle: ButtonStyle {
    private let isSelected: Bool
    private let modifiable: Bool
    
    init(
        isSelected: Bool,
        modifiable: Bool
    ) {
        self.isSelected = isSelected
        self.modifiable = modifiable
    }
    
    func makeBody(configuration: Configuration) -> some View {
        configuration
            .label
            .background(
                RoundedRectangle(cornerRadius: 24)
                    .fill(backgroundColor(isPressed: configuration.isPressed))
                    .shadow(
                        color: Color(.staticBlack).opacity(0.25),
                        radius: 4,
                        y: 4
                    )
            )
            .overlay(
                RoundedRectangle(cornerRadius: 24)
                    .stroke(
                        borderColor(),
                        lineWidth: borderWidth()
                    )
            )
    }
    
    private func backgroundColor(isPressed: Bool) -> Color  {
        let isAblePressedColor = isPressed ? Color(.labelNormal).opacity(0.12) : Color(.backgroundAlternative)
        let isDisablePressedColor = isPressed ? Color(.labelNormal).opacity(0.12) : Color(.backgroundNormal)
        
        return modifiable ? isAblePressedColor : isDisablePressedColor
    }
    
    private func borderColor() -> Color {
        let isSelectedColor = isSelected ? Color(.lineStrong) : Color(.lineAlternative)
        
        return modifiable ? isSelectedColor : Color(.lineAlternative)
    }
    
    private func borderWidth() -> CGFloat {
        modifiable ? 1 : 3
    }
}
