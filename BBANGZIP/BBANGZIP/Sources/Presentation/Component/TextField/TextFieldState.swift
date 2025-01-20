//
//  TextFieldState.swift
//  BBANGZIP
//
//  Created by 조성민 on 1/16/25.
//  Copyright © 2025 com.bbangzip. All rights reserved.
//

import SwiftUI

enum TextFieldState {
    case defaultState
    case placeholder
    case typing
    case alert
    case field
    
    var backgroundColor: Color {
        switch self {
        case .defaultState, .alert, .field:
            Color(.fillNormal)
        case .placeholder, .typing:
            Color(.fillStrong)
        }
    }
    
    var iconColor: Color {
        switch self {
        case .defaultState:
            Color(.labelAssistive)
        case .placeholder, .typing, .alert, .field:
            Color(.labelAlternative)
        }
    }
    
    var announceColor: Color {
        switch self {
        case .defaultState, .field:
            Color(.labelAssistive)
        case .alert:
            Color(.statusDestructive)
        case .placeholder, .typing:
            Color(.labelAlternative)
        }
    }
    
    var strokeColor: Color {
        switch self {
        case .alert:
            Color(.statusDestructive)
        default:
            Color.clear
        }
    }
    
    var showCancelButton: Bool {
        switch self {
        case .defaultState, .placeholder:
            false
        case .typing, .alert, .field:
            true
        }
    }
}
