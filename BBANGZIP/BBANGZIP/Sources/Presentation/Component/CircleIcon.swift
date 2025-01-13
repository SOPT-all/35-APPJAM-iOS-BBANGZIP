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
        ZStack {
            Circle()
                .stroke(Color(.lineNormal), lineWidth: 1)
                .frame(width: 40, height: 40)
            
            Image(name)
                .resizable()
                .frame(width: 20, height: 20)
                .scaledToFill()
        }
        .frame(width: 40, height: 40)
    }
}

#Preview {
    CircleIcon(iconName: "bubble")
}
