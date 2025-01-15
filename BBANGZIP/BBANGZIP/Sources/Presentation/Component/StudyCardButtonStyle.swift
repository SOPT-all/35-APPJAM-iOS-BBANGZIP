//
//  StudyCardButtonStyle.swift
//  BBANGZIP
//
//  Created by 최유빈 on 1/15/25.
//  Copyright © 2025 com.bbangzip. All rights reserved.
//

import SwiftUI

struct StudyCardButtonStyle: ButtonStyle {
    func makeBody(configuration: Configuration) -> some View {
        if configuration.isPressed {
            configuration
                .label
                .background(RoundedRectangle(cornerRadius: 24)
                    .fill(BBANGZIPAsset.Assets.backgroundAlternative.swiftUIColor))
        }
        else {
            configuration
                .label
                .background(RoundedRectangle(cornerRadius: 24)
                    .fill(BBANGZIPAsset.Assets.backgroundNormal.swiftUIColor))
        }
    }
}
