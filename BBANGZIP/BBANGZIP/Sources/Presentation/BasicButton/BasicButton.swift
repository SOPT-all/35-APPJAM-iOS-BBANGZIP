//
//  OutlinedButton.swift
//  BBANGZIP
//
//  Created by 최유빈 on 1/12/25.
//  Copyright © 2025 com.bbangzip. All rights reserved.
//

import SwiftUI

struct BasicButton: ButtonStyle {
    
    var fontType = BbangFont.body2
    var verticalPadding: CGFloat = 9
    var customCornerRadius: CGFloat = 16
    
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .applyFont(font: fontType)
            .padding(.init(vertical: verticalPadding))
            .frame(maxWidth: .infinity)
            .overlay(RoundedRectangle(cornerRadius: customCornerRadius)
                .stroke(Color("LineStrong"), lineWidth: 1)
            )
    }
}

extension EdgeInsets {
    var verticalInset: CGFloat { self.top + self.bottom }
    
    static func vertical(_ vertical: CGFloat, left: CGFloat = 0, right: CGFloat = 0) -> UIEdgeInsets {
        UIEdgeInsets(
            top: vertical,
            left: left,
            bottom: vertical,
            right: right
        )
    }
    
    init(vertical: CGFloat = 0) {
        self = EdgeInsets(
            top: vertical,
            leading: 0,
            bottom: vertical,
            trailing: 0
        )
    }
}
