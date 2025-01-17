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
    
    init(isSelected: Bool, modifiable: Bool) {
        self.isSelected = isSelected
        self.modifiable = modifiable
    }
    
    func makeBody(configuration: Configuration) -> some View {
        configuration
            .label
            .background(
                RoundedRectangle(cornerRadius: 24)
                    .fill(backgroundColor(isPressed: configuration.isPressed)))
            .overlay(
                RoundedRectangle(cornerRadius: 24)
                    .stroke(borderColor(), lineWidth: borderWidth()))
    }
    
    private func backgroundColor(isPressed: Bool) -> Color  {
        if modifiable {
            isPressed ? Color(.labelNormal).opacity(0.12) : Color(.backgroundAlternative)
        } else {
            isPressed ? Color(.labelNormal).opacity(0.12) : Color(.backgroundNormal)
        }
    }
    
    private func borderColor() -> Color {
        if modifiable {
            isSelected ? Color(.lineStrong) : Color(.lineAlternative)
        } else {
            Color(.lineAlternative)
        }
    }
    
    private func borderWidth() -> CGFloat {
        if modifiable {
            3
        } else {
            1
        }
    }
}
