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
    case subject
    case message
    
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
        case .subject:
            Image(.book)
        case .message:
            Image(.bubble)
        }
    }
    
    var maxLength: Int? {
        switch self {
        case .nickname:
            8
        case .date, .studyRange:
            4
        case .studyContent:
            20
        case .subject:
            10
        case .message:
            25
        }
    }
    
    var clearable: Bool {
        switch self {
        case .nickname, .subject, .message:
            true
        case .date, .studyContent, .studyRange:
            false
        }
    }
    
    var countable: Bool {
        switch self {
        case .date, .studyRange:
            false
        case .nickname, .studyContent, .subject, .message:
            true
        }
    }
}
