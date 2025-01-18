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
    case alert
    case complete
    case filled
    
    var backgroundColor: Color {
        switch self {
        case .defaultState, .alert, .complete, .filled:
            Color(.fillNormal)
        case .placeholder:
            Color(.fillStrong)
        }
    }
    
    var iconColor: Color {
        switch self {
        case .defaultState:
            Color(.labelAssistive)
        case .placeholder, .alert, .complete, .filled:
            Color(.labelAlternative)
        }
    }
    
    var textColor: Color {
        switch self {
        case .defaultState:
            Color(.labelDisable)
        case .placeholder, .alert, .complete, .filled:
            Color(.labelAlternative)
        }
    }
    
    var announceColor: Color {
        switch self {
        case .defaultState, .placeholder, .filled:
            Color(.labelAssistive)
        case .alert:
            Color(.statusDestructive)
        case .complete:
            Color(.statusPositive)
        }
    }
    
    var strokeColor: Color {
        switch self {
        case .alert:
            Color(.statusDestructive)
        case .complete:
            Color(.statusPositive)
        default:
            Color.clear
        }
    }
    
    var showCancelButton: Bool {
        switch self {
        case .defaultState, .placeholder, .filled:
            false
        case .alert, .complete:
            true
        }
    }
}
