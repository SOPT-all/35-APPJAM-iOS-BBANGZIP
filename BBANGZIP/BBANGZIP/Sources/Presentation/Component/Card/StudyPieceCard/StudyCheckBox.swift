//
//  StudyCheckBox.swift
//  BBANGZIP
//
//  Created by 최유빈 on 1/22/25.
//  Copyright © 2025 com.bbangzip. All rights reserved.
//

import SwiftUI

struct StudyCheckBox: View {
    private let state: StudyPieceCardState
    
    init(state: StudyPieceCardState) {
        self.state = state
    }
    
    var body: some View {
        
        Image(.checkIcon)
            .renderingMode(.template)
            .foregroundStyle(state == StudyPieceCardState.complete ? Color(.staticWhite) : .clear)
            .padding(2)
            .background(RoundedRectangle(cornerRadius: 12)
                .fill(state == StudyPieceCardState.complete ? Color(.secondaryNormal) : Color(.fillStrong)))
    }
}
