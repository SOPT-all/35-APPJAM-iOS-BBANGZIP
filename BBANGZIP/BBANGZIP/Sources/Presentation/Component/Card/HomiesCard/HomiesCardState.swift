//
//  HomiesCardState.swift
//  BBANGZIP
//
//  Created by 김송희 on 1/16/25.
//  Copyright © 2025 com.bbangzip. All rights reserved.
//

import SwiftUI

protocol CardState {
    var backgroundColor: Color { get }
    var borderColor: Color { get }
}

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
        case .selected:
            Color(.lineStrong)
        default:
            Color.clear
        }
    }
}
