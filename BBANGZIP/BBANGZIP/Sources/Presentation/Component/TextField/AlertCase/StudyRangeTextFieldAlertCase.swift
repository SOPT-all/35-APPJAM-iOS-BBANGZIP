//
//  StudyRangeTextFieldAlertCase.swift
//  BBANGZIP
//
//  Created by 김송희 on 1/20/25.
//  Copyright © 2025 com.bbangzip. All rights reserved.
//

import SwiftUI

enum StudyRangeTextFieldAlertCase: TextFieldAlertable {
    case startAlert
    case endAlert
    case startLimitWrong
    case endLimitWrong
    case rangeFlippedWrong
    case zero
    
    var alertText: String {
        switch self {
        case .startAlert:
            "부터"
        case .endAlert:
            "까지"
        case .startLimitWrong, .rangeFlippedWrong:
            "시작 범위 이후로 입력해 주세요"
        case .endLimitWrong:
            "종료 범위 이전으로 입력해 주세요"
        case .zero:
            "0p는 입력할 수 없어요"
        }
    }
}
