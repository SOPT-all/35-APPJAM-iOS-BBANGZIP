//
//  HomiesState.swift
//  BBANGZIP
//
//  Created by 김송희 on 1/16/25.
//  Copyright © 2025 com.bbangzip. All rights reserved.
//

import SwiftUI

enum HomiesState {
    case basic
    case checked
    case holding
    
    var backgroundColor: Color {
        switch self {
        case .basic:
            Color(.backgroundNormal)
        case .checked, .holding:
            Color(.backgroundAlternative)
        }
    }

    var borderColor: Color {
        switch self {
        case .checked:
            Color(.lineStrong)
        default:
            Color.clear
        }
    }
}
