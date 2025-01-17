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
            .overlay(RoundedRectangle(cornerRadius: 16)
                .stroke(Color(.lineStrong), lineWidth: 1)
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
            .overlay(RoundedRectangle(cornerRadius: 24)
                .stroke(Color(.lineStrong), lineWidth: 1)
            )
    }
}

struct SolidButton: ButtonStyle {
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .applyFont(font: .body1Bold)
            .foregroundStyle(Color(.staticWhite))
            .padding(
                .vertical,
                16
            )
            .frame(maxWidth: .infinity)
            .background(Color(.primaryNormal))
            .cornerRadius(24)
    }
}

struct SolidIconButton: ButtonStyle {
    private let systemName: String
    
    init(systemName: String) {
        self.systemName = systemName
    }
    
    func makeBody(configuration: Configuration) -> some View {
        HStack (spacing: 6) {
            Spacer()
            
            configuration.label
                .applyFont(font: .body1Bold)
                .foregroundStyle(Color(.staticWhite))
                .padding(
                    .vertical,
                    16
                )
            
            Image(systemName: systemName)
                .foregroundStyle(Color(.staticWhite))
                .padding(
                    .vertical,
                    18
                )
            
            Spacer()
        }
        .frame(maxWidth: .infinity)
        .background(Color(.primaryNormal))
        .cornerRadius(24)
    }
}
