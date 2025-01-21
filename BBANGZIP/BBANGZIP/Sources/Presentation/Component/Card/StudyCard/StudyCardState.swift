//
//  StudyCardState.swift
//  BBANGZIP
//
//  Created by 최유빈 on 1/21/25.
//  Copyright © 2025 com.bbangzip. All rights reserved.
//

import SwiftUI

enum StudyCardState: CardState {
    case cardDefault
    case selected
    case selectable
    case complete
    
    var backgroundColor: Color {
        switch self {
        case .cardDefault, .complete:
            Color(.backgroundNormal)
        case .selected, .selectable:
            Color(.backgroundAlternative)
        }
    }
    
    var borderColor: Color {
        switch self {
        case .cardDefault, .selectable, .complete:
            Color(.lineAlternative)
        case .selected:
            Color(.lineStrong)
        }
    }
    
    var borderWidth: CGFloat {
        switch self {
        case .cardDefault, .selectable, .complete:
            1
        case .selected:
            2
        }
    }
}

