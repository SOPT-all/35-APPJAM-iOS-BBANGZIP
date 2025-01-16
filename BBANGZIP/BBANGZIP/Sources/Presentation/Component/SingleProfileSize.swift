//
//  SingleProfileSize.swift
//  BBANGZIP
//
//  Created by 김송희 on 1/16/25.
//  Copyright © 2025 com.bbangzip. All rights reserved.
//

import SwiftUI

enum SingleProfileSize {
    case medium
    case large
    
    var dimension: CGFloat {
        switch self {
        case .medium: return 48
        case .large: return 96
        }
    }
}
