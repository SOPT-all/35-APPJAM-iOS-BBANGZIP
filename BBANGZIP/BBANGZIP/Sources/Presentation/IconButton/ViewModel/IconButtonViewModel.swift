//
//  IconButtonViewModel.swift
//  BBANGZIP
//
//  Created by 김송희 on 1/13/25.
//  Copyright © 2025 com.bbangzip. All rights reserved.
//

import SwiftUI

class IconButtonViewModel: ObservableObject {
    
    @Published var isPressed: Bool = false
    let iconName: String
    let iconSize: CGFloat
    let color: String
    let clickable: Bool
    let outlinable: Bool
    let interactable: Bool
    let onTapButton: () -> Void
    
    init(
        iconName: String,
        size: CGFloat = 24,
        color: String = "LabelAlternative",
        clickable: Bool = true,
        outlinable: Bool = false,
        interactable: Bool = true,
        onTapButton: @escaping () -> Void
    ) {
        self.iconName = iconName
        self.iconSize = size
        self.color = color
        self.clickable = clickable
        self.outlinable = outlinable
        self.interactable = interactable
        self.onTapButton = onTapButton
    }
    
    func handleTap() {
        if clickable {
            onTapButton()
        }
    }
    
    func setPressedState(_ pressed: Bool) {
        isPressed = pressed
    }
}
