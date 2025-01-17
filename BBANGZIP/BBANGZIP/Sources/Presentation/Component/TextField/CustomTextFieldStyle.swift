//
//  CustomTextFieldStyle.swift
//  BBANGZIP
//
//  Created by 조성민 on 1/15/25.
//  Copyright © 2025 com.bbangzip. All rights reserved.
//

import SwiftUI

struct CustomTextFieldStyle: TextFieldStyle {
    private let state: TextFieldState
    private let style: TextFieldStyleCase
    private let alertCase: TextFieldAlertable?
    @Binding private var text: String
    
    init(
        text: Binding<String>,
        style: TextFieldStyleCase,
        state: TextFieldState,
        alertText: TextFieldAlertable? = nil
    ) {
        self._text = text
        self.style = style
        self.state = state
        self.alertCase = alertText
    }
    
    private var backgroundView: some View {
        RoundedRectangle(cornerRadius: 20)
            .fill(state.backgroundColor)
            .overlay(
                RoundedRectangle(cornerRadius: 20)
                    .stroke(
                        state.strokeColor,
                        lineWidth: 1
                    )
            )
    }
    
    func _body(configuration: TextField<Self._Label>) -> some View {
        VStack(
            alignment: .leading,
            spacing: 4
        ) {
            ZStack {
                backgroundView
                
                HStack {
                    if let icon = style.icon {
                        icon
                            .renderingMode(.template)
                            .foregroundStyle(state.iconColor)
                            .padding(.leading, 16)
                    }
                    
                    configuration
                        .applyFont(font: .label1Medium)
                        .foregroundStyle(state.textColor)
                        .padding(.leading, 6)
                    
                    HStack(spacing: 8) {
                        if let maxLength = style.maxLength {
                            CustomText(
                                "\(text.count)/\(maxLength)",
                                fontType: .caption1Medium,
                                color: state.textColor
                            )
                        }
                        
                        if style.clearable, state.showCancelButton {
                            Image(.X)
                                .renderingMode(.template)
                                .frame(width: 24, height: 24)
                                .foregroundStyle(state.textColor)
                                .onTapGesture {
                                    text = ""
                                }
                        }
                    }
                    .padding(.trailing, 12)
                }
            }
            .frame(height: 56)
            if let alertText = alertCase?.alertText {
                CustomText(
                    alertText,
                    fontType: .caption2Medium,
                    color: state.announceColor
                )
                .padding(.leading, 8)
            }
        }
    }
}
