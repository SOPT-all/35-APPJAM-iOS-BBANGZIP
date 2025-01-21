//
//  CheckBox.swift
//  BBANGZIP
//
//  Created by 최유빈 on 1/15/25.
//  Copyright © 2025 com.bbangzip. All rights reserved.
//

import SwiftUI

struct CheckBox: View {
    private let state: StudyCardState
    
    init(state: StudyCardState) {
        self.state = state
    }
    
    var body: some View {
        
        Image(.checkIcon)
            .renderingMode(.template)
            .foregroundStyle(state == StudyCardState.complete ? Color(.staticWhite) : .clear)
            .padding(2)
            .background(RoundedRectangle(cornerRadius: 12)
                .fill(state == StudyCardState.complete ? Color(.secondaryNormal) : Color(.fillStrong)))
    }
}

#Preview {
//    VStack (spacing: 20) {
//        CheckBox(isCompleted: true)
//        
//        CheckBox(isCompleted: false)
//    }
}
