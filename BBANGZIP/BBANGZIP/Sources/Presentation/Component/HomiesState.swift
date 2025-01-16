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
            return Color(.backgroundNormal)
        case .checked, .holding:
            return Color(.backgroundAlternative)
        }
    }

    var borderColor: Color {
        switch self {
        case .checked:
            return Color(.lineStrong)
        default:
            return Color.clear
        }
    }
}
