//
//  Step.swift
//  BBANGZIP
//
//  Created by 최유빈 on 1/14/25.
//  Copyright © 2025 com.bbangzip. All rights reserved.
//

import SwiftUI

enum Step: Int {
    case first = 1
    case second = 2
    case third = 3
    
    var percentage: CGFloat {
        switch self {
        case .first:
            0.04
        case .second:
            0.5
        case .third:
            1
        }
    }
}
