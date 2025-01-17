//
//  ChipType.swift
//  BBANGZIP
//
//  Created by 송여경 on 1/18/25.
//  Copyright © 2025 com.bbangzip. All rights reserved.
//

import SwiftUI

enum ChipType {
    case daysRemaining(
        Int,
        withExamLabel: Bool
    )
    case points(Int)
    case level(Int)
    
    var text: String {
        switch self {
        case .daysRemaining(
            let days,
            let withExamLabel
        ):
            if withExamLabel {
                "시험까지 D - \(days)"
            } else if days >= 0 {
                "D + \(days)"
            } else {
                "D - \(-days)"
            }
        case .points(let points):
            "\(points)P"
        case .level(let level):
            "Lv \(level)"
        }
    }
}
