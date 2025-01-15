//
//  CheckBox.swift
//  BBANGZIP
//
//  Created by 최유빈 on 1/15/25.
//  Copyright © 2025 com.bbangzip. All rights reserved.
//

import SwiftUI

struct CheckBox: View {
    private let isChecked: Bool
    
    init(isChecked: Bool) {
        self.isChecked = isChecked
    }
    
    var body: some View {
        Image(.checkIcon)
            .renderingMode(.template)
            .foregroundStyle(isChecked ? BBANGZIPAsset.Assets.staticWhite.swiftUIColor : .clear)
            .padding(2)
            .background(RoundedRectangle(cornerRadius: 12)
                .fill(isChecked ? BBANGZIPAsset.Assets.secondaryNormal.swiftUIColor : BBANGZIPAsset.Assets.fillStrong.swiftUIColor))
    }
}

#Preview {
    VStack (spacing: 20) {
        CheckBox(isChecked: true)
        
        CheckBox(isChecked: false)
    }
}
