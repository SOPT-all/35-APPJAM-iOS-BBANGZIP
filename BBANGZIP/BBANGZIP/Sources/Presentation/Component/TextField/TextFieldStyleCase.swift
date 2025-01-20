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
    case date
    case studyContent
    case studyRange
    
    var icon: Image? {
        switch self {
        case .nickname:
            Image(.userSmall)
        case .date:
            Image(.calenderSmall)
        case .studyContent:
            Image(.bookSmall)
        case .studyRange:
            Image(.checkSmall)
        }
    }
    
    var maxLength: Int? {
        switch self {
        case .nickname:
            8
        case .date, .studyRange:
            nil
        case .studyContent:
            20
        }
    }
    
    var clearable: Bool {
        switch self {
        case .nickname:
            true
        case .date, .studyContent, .studyRange:
            false
        }
    }
}
