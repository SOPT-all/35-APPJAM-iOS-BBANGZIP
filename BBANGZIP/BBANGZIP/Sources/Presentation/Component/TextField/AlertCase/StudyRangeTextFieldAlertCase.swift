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
    case startLimitWrong
    case endLimitWrong
    case rangeFlippedWrong
    
    var alertText: String {
        switch self {
        case .startDefaultCorrect:
            "부터"
        case .endDefaultCorrect:
            "까지"
        case .startLimitWrong, .rangeFlippedWrong:
            "시작범위 이후로 입력해주세요"
        case .endLimitWrong:
            "종료범위 이전으로 입력해주세요"
        }
    }
}
