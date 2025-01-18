//
//  ChipType.swift
//  BBANGZIP
//
//  Created by 송여경 on 1/18/25.
//  Copyright © 2025 com.bbangzip. All rights reserved.
//

import SwiftUI

enum ChipType {
    case daysLeftWithText(Int)
    case daysLeftGray(Int)
    case daysLeftBlack(Int)
    case delayedDate(Int)
    case points(Int)
    case level(Int)
    
    var text: String {
        switch self {
        case .daysLeftWithText(let days):
            "시험까지  D\(days)"
        case .daysLeftGray(let days):
            "D\(days)"
        case .daysLeftBlack(let days):
            "D\(days)"
        case .delayedDate(let days):
            "D+\(days)"
        case .points(let points):
            "\(points)P"
        case .level(let level):
            "Lv.\(level)"
        }
    }
    
    var color: Color {
        switch self {
        case .daysLeftWithText(_):
            Color(.statusPositive)
        case .daysLeftGray(_):
            Color(.labelAlternative)
        case .daysLeftBlack(_):
            Color(.statusPositive)
        case .delayedDate(_):
            Color(.statusDestructive)
        case .points(_):
            Color(.statusCautionary)
        case .level(_):
            Color(.statusPositive)
        }
    }
}
