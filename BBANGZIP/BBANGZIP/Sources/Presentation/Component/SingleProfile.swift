//
//  SingleProfile.swift
//  BBANGZIP
//
//  Created by 김송희 on 1/16/25.
//  Copyright © 2025 com.bbangzip. All rights reserved.
//

import SwiftUI

struct SingleProfile: View {
    private let size: SingleProfileSize
    private let outlined: Bool
    
    init(size: SingleProfileSize, outlined: Bool) {
        self.size = size
        self.outlined = outlined
    }
    
    var body: some View {
        Image(.person)
            .resizable()
            .scaledToFit()
            .frame(
                width: size.dimension,
                height: size.dimension
            )
            .clipShape(Circle())
            .overlay(
                Circle()
                    .stroke(outlined ? Color(.lineNormal) : Color.clear, lineWidth: 1)
            )
    }
}

#Preview {
    HStack {
        SingleProfile(size: .large, outlined: true)
        SingleProfile(size: .large, outlined: false)
        SingleProfile(size: .medium, outlined: true)
        SingleProfile(size: .medium, outlined: false)
    }
}
