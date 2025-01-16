//
//  StudyCardButtonStyle.swift
//  BBANGZIP
//
//  Created by 최유빈 on 1/15/25.
//  Copyright © 2025 com.bbangzip. All rights reserved.
//

import SwiftUI

enum ButtonState {
    case base
    case selectable
}

struct StudyCardButtonStyle: ButtonStyle {
    @Binding var isSelected: Bool
    let state: ButtonState
    
    func makeBody(configuration: Configuration) -> some View {
        configuration
            .label
            .background(RoundedRectangle(cornerRadius: 24)
                .fill(backgroundColor(state: state, isPressed: configuration.isPressed)))
            .overlay(RoundedRectangle(cornerRadius: 24)
                .stroke(borderColor(state: state), lineWidth: borderWidth(state: state)))
    }
    
    private func backgroundColor(state: ButtonState, isPressed: Bool) -> Color  {
        switch state {
        case .base:
            isPressed ? BBANGZIPAsset.Assets.labelNormal.swiftUIColor.opacity(0.12) : BBANGZIPAsset.Assets.backgroundNormal.swiftUIColor
        case .selectable:
            isPressed ? BBANGZIPAsset.Assets.labelNormal.swiftUIColor.opacity(0.12) : BBANGZIPAsset.Assets.backgroundAlternative.swiftUIColor
        }
    }
    
    private func borderColor(state: ButtonState) -> Color {
        switch state {
        case .base:
            BBANGZIPAsset.Assets.lineAlternative.swiftUIColor
        case .selectable:
            isSelected ? BBANGZIPAsset.Assets.lineStrong.swiftUIColor : BBANGZIPAsset.Assets.lineAlternative.swiftUIColor
        }
    }
    
    private func borderWidth(state: ButtonState) -> CGFloat {
        switch state {
        case .base:
            1
        case .selectable:
            isSelected ? 3 : 1
        }
    }
}

 
// default : backgroundNormal / lineAlternative, 1
// 삭제 버튼 클릭 시 : backgroundAlternative / lineAlternative, 1 -> isSelectDelete
// 삭제 선택 시 : backgroundAlternative / lineStrong, 3 -> isSelected == true
// pressed시 : labelNormal.opacity(0.12) / lineStrong, 3    -> configuration.isPressed == true
// 완료 선택 시 : backgroundNormal / lineAlternative, 1 / VStack.opacity(0.4) -> isCompleted

// base -> (touch) -> isCompleted
// base -> case = selectable -> (touch) -> isSelected
