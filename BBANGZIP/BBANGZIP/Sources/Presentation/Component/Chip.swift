//
//  Chip.swift
//  BBANGZIP
//
//  Created by 최유빈 on 1/16/25.
//  Copyright © 2025 com.bbangzip. All rights reserved.
//

import SwiftUI

struct Chip: View {
    var body: some View {
        BbangText (
            "D-14",
            fontType: .caption1,
            color: Color(BBANGZIPAsset.Assets.staticWhite.color)
        )
        .padding(.vertical, 2)
        .padding(.horizontal, 12)
        .background(Capsule()
            .fill(Color(BBANGZIPAsset.Assets.labelAlternative.color)))
    }
}

#Preview {
    Chip()
}
