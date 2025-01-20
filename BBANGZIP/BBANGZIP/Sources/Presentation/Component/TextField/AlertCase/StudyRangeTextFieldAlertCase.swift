//
//  StudyRangeTextFieldAlertCase.swift
//  BBANGZIP
//
//  Created by 김송희 on 1/20/25.
//  Copyright © 2025 com.bbangzip. All rights reserved.
//

import SwiftUI

enum StudyRangeTextFieldAlertCase: TextFieldAlertable {
    case startDefaultCorrect
    case endDefaultCorrect
    case completeCorrect
    
    var alertText: String {
        switch self {
        case .startDefaultCorrect:
            "부터"
        case .endDefaultCorrect:
            "까지"
        case .completeCorrect:
            "사용 가능한 이름이에요"
        }
    }
}
