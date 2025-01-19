//
//  HomiesCardState.swift
//  BBANGZIP
//
//  Created by 김송희 on 1/16/25.
//  Copyright © 2025 com.bbangzip. All rights reserved.
//

import SwiftUI

enum HomiesCardState: CardState {
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
            Color(.lineAlternative)
        case .selected:
            Color(.lineStrong)
        }
    }
    
    var borderWidth: CGFloat {
        switch self {
        case .cardDefault, .selectable:
            1
        case .selected:
            3
        }
    }
}
