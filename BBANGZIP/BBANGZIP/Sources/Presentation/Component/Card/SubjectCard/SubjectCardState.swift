//
//  SubjectCardState.swift
//  BBANGZIP
//
//  Created by 조성민 on 1/17/25.
//  Copyright © 2025 com.bbangzip. All rights reserved.
//

import SwiftUI

enum SubjectCardState: CardState {
    case cardDefault
    case selected
    case selectable
    
    var backgroundColor: Color {
        switch self {
        case .cardDefault:
            Color(.backgroundNormal)
        case .selected, .selectable:
            Color(.backgroundAlternative)
        }
    }
    
    var borderColor: Color {
        switch self {
        case .cardDefault, .selectable:
            Color.clear
        case .selected:
            Color(.lineStrong)
        }
    }
}
