//
//  CircleIcon.swift
//  BBANGZIP
//
//  Created by 김송희 on 1/13/25.
//  Copyright © 2025 com.bbangzip. All rights reserved.
//

import SwiftUI

struct CircleIcon: View {
    private let name: String
    
    init(iconName: String) {
        self.name = iconName
    }
    
    var body: some View {
        GeometryReader { geometry in
            ZStack {
                Circle()
                    .stroke(
                        Color(.lineNormal),
                        lineWidth: 1
                    )
                
                Image(name)
                    .resizable()
                    .scaledToFill()
                    .padding(geometry.size.width * 0.25)
            }
        }
        .aspectRatio(
            1,
            contentMode: .fit
        )
    }
}
