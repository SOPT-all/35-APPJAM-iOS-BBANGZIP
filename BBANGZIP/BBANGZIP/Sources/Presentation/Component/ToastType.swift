//
//  ToastType.swift
//  BBANGZIP
//
//  Created by 김송희 on 1/16/25.
//  Copyright © 2025 com.bbangzip. All rights reserved.
//

import SwiftUI

enum ToastType {
    case singleLine
    case doubleLine
    
    var verticalInset: CGFloat {
        switch self {
        case .singleLine: 11
        case .doubleLine: 10
        }
    }
    
    var horizontalInset: CGFloat {
        switch self {
        case .singleLine: 24
        case .doubleLine: 48
        }
    }
    
    var radius: CGFloat {
        switch self {
        case .singleLine: 16
        case .doubleLine: 24
        }
    }
}
