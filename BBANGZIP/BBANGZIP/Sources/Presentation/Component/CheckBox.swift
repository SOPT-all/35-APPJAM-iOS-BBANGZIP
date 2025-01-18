//
//  CheckBox.swift
//  BBANGZIP
//
//  Created by 최유빈 on 1/15/25.
//  Copyright © 2025 com.bbangzip. All rights reserved.
//

import SwiftUI

struct CheckBox: View {
    private let isCompleted: Bool
    
    init(isCompleted: Bool) {
        self.isCompleted = isCompleted
    }
    
    var body: some View {
        Image(.checkIcon)
            .renderingMode(.template)
            .foregroundStyle(isCompleted ? Color(.staticWhite) : .clear)
            .padding(2)
            .background(RoundedRectangle(cornerRadius: 12)
                .fill(isCompleted ? Color(.secondaryNormal) : Color(.fillStrong)))
    }
}

#Preview {
    VStack (spacing: 20) {
        CheckBox(isCompleted: true)
        
        CheckBox(isCompleted: false)
    }
}
