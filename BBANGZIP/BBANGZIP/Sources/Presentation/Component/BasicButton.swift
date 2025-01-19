//
//  BasicButton.swift
//  BBANGZIP
//
//  Created by 최유빈 on 1/12/25.
//  Copyright © 2025 com.bbangzip. All rights reserved.
//

import SwiftUI

struct OutlinedMediumButton: ButtonStyle {
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .applyFont(font: .body2Bold)
            .foregroundStyle(Color(.primaryNormal))
            .padding(
                .vertical,
                9
            )
            .frame(maxWidth: .infinity)
            .cornerRadius(16)
            .overlay(
                RoundedRectangle(cornerRadius: 16)
                    .stroke(
                        Color(.lineStrong),
                        lineWidth: 1
                    )
            )
    }
}

struct OutlinedLargeButton: ButtonStyle {
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .applyFont(font: .body1Bold)
            .foregroundStyle(Color(.primaryNormal))
            .padding(
                .vertical,
                16
            )
            .frame(maxWidth: .infinity)
            .cornerRadius(24)
            .overlay(
                RoundedRectangle(cornerRadius: 24)
                    .stroke(
                        Color(.lineStrong),
                        lineWidth: 1
                    )
            )
    }
}

struct SolidButton: ButtonStyle {
    private let isEnabled: Bool
    
    init(_ isEnabled: Bool = true) {
        self.isEnabled = isEnabled
    }
    
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .applyFont(font: .body1Bold)
            .foregroundStyle(Color(isEnabled ? .staticWhite : .labelDisable))
            .padding(
                .vertical,
                16
            )
            .frame(maxWidth: .infinity)
            .background(Color(isEnabled ? .primaryNormal : .interactionDisable))
            .cornerRadius(24)
    }
}

struct SolidIconButton: ButtonStyle {
    private let buttonImage: Image
    private let isEnabled: Bool
    
    init(
        buttonImage: Image,
        _ isEnabled: Bool = true
    ) {
        self.buttonImage = buttonImage
        self.isEnabled = isEnabled
    }
    
    func makeBody(configuration: Configuration) -> some View {
        HStack (spacing: 6) {
            Spacer()
            
            configuration.label
                .applyFont(font: .body1Bold)
                .foregroundStyle(Color(isEnabled ? .staticWhite : .labelDisable))
                .padding(
                    .vertical,
                    16
                )
           
            buttonImage
                .resizable()
                .renderingMode(.template)
                .foregroundStyle(Color(isEnabled ? .staticWhite : .labelDisable))
                .frame(
                    width: 20,
                    height: 20
                )
            
            Spacer()
        }
        .frame(maxWidth: .infinity)
        .background(Color(isEnabled ? .primaryNormal : .interactionDisable))
        .cornerRadius(24)
    }
}
