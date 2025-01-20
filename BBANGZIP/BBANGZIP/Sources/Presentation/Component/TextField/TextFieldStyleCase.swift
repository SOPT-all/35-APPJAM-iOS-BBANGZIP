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
    case subject
    
    var icon: Image? {
        switch self {
        case .nickname:
            Image(.user)
        case .subject:
            Image(.book)
        }
    }
    
    var maxLength: Int? {
        switch self {
        case .nickname:
            8
        case .subject:
            10
        }
    }
    
    var clearable: Bool {
        switch self {
        case .nickname, .subject:
            true
        }
    }
}
