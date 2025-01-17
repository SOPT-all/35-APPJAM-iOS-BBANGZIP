//
//  TextFieldStyleCase.swift
//  BBANGZIP
//
//  Created by 조성민 on 1/16/25.
//  Copyright © 2025 com.bbangzip. All rights reserved.
//

import SwiftUI

enum TextFieldStyleCase {
    case nickname
    
    var icon: Image? {
        switch self {
        case .nickname:
            Image(.user)
        }
    }
    
    var maxLength: Int? {
        switch self {
        case .nickname:
            8
        }
    }
    
    var clearable: Bool {
        switch self {
        case .nickname:
            true
        }
    }
}
