//
//  IconButtonView.swift
//  BBANGZIP
//
//  Created by 김송희 on 1/12/25.
//  Copyright © 2025 com.bbangzip. All rights reserved.
//

import SwiftUI

struct IconButtonView: View {
    @StateObject var viewModel: IconButtonViewModel
    
    init(
        iconName: String,
        size: CGFloat = 24,
        color: String = "LabelAlternative",
        clickable: Bool = true,
        outlinable: Bool = false,
        interactable: Bool = true,
        onTapButton: @escaping () -> Void = {}
    ) {
        _viewModel = StateObject(wrappedValue: IconButtonViewModel(
            iconName: iconName,
            size: size,
            color: color,
            clickable: clickable,
            outlinable: outlinable,
            interactable: interactable,
            onTapButton: onTapButton
        ))
    }
    
    var body: some View {
        Button(action: {
            viewModel.handleTap()
        }) {
            ZStack {
                if viewModel.isPressed && viewModel.interactable {
                    Circle()
                        .fill(Color("LabelNormal").opacity(0.12))
                        .frame(width: 40, height: 40)
                }
                
                Image(viewModel.iconName)
                    .renderingMode(.template)
                    .resizable()
                    .frame(width: viewModel.iconSize, height: viewModel.iconSize)
                    .scaledToFill()
                    .foregroundStyle(
                        viewModel.clickable ? Color(
                            viewModel.color
                        ) : Color("LabelDisable")
                    )
            }
            .frame(
                width: viewModel.interactable ? 40 : viewModel.iconSize,
                height: viewModel.interactable ? 40 : viewModel.iconSize
            )
        }
        .buttonStyle(PlainButtonStyle())
        .disabled(!viewModel.clickable)
        .overlay(
            viewModel.outlinable ? Circle()
                .stroke(Color("LineNormal"), lineWidth: 1)
                .frame(width: 40, height: 40
                      ) : nil
        )
        .simultaneousGesture(
            DragGesture(minimumDistance: 0)
                .onChanged { _ in
                    if viewModel.clickable {
                        viewModel.setPressedState(true)
                    }
                }
                .onEnded{ _ in
                    viewModel.setPressedState(false)
                }
        )
    }
}

#Preview {
    HStack(spacing: 0) {
        IconButtonView(
            iconName: "bubble",
            size: 20,
            color: "LabelNeutral",
            clickable: true,
            outlinable: true,
            interactable: true,
            onTapButton: {}
        )
        
        IconButtonView(
            iconName: "bubble",
            size: 24,
            color: "LabelNormal",
            clickable: true,
            outlinable: false,
            interactable: true,
            onTapButton: {}
        )
        
        IconButtonView(
            iconName: "bubble",
            size: 16,
            color: "LabelNormal",
            clickable: false,
            outlinable: false,
            interactable: false,
            onTapButton: {}
        )
        
        IconButtonView(
            iconName: "bubble",
            clickable: true,
            onTapButton: {
                print("Button tapped!")
            }
        )
    }
}
