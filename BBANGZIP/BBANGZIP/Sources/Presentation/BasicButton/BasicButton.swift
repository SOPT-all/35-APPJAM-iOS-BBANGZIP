//
//  OutlinedButton.swift
//  BBANGZIP
//
//  Created by 최유빈 on 1/12/25.
//  Copyright © 2025 com.bbangzip. All rights reserved.
//

import SwiftUI

struct OutlinedMediumButton: ButtonStyle {
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .applyFont(font: .body2)
            .foregroundStyle(Color(BBANGZIPAsset.Assets.primaryNormal.color))
            .padding(.vertical, 9)
            .frame(maxWidth: .infinity)
            .cornerRadius(16)
            .overlay(RoundedRectangle(cornerRadius: 16)
                .stroke(Color(BBANGZIPAsset.Assets.lineStrong.color), lineWidth: 1)
            )
    }
}

struct OutlinedLargeButton: ButtonStyle {
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .applyFont(font: .body1)
            .foregroundStyle(Color(BBANGZIPAsset.Assets.primaryNormal.color))
            .padding(.vertical, 16)
            .frame(maxWidth: .infinity)
            .cornerRadius(24)
            .overlay(RoundedRectangle(cornerRadius: 24)
                .stroke(Color(BBANGZIPAsset.Assets.lineStrong.color), lineWidth: 1)
            )
    }
}

struct SolidButton: ButtonStyle {
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .applyFont(font: .body1)
            .foregroundStyle(Color(BBANGZIPAsset.Assets.staticWhite.color))
            .padding(.vertical, 16)
            .frame(maxWidth: .infinity)
            .background(Color(BBANGZIPAsset.Assets.primaryNormal.color))
            .cornerRadius(24)
    }
}
