//
//  StudyContentTextFieldAlertCase.swift
//  BBANGZIP
//
//  Created by 김송희 on 1/20/25.
//  Copyright © 2025 com.bbangzip. All rights reserved.
//

import SwiftUI

enum StudyContentTextFieldAlertCase: TextFieldAlertable {
    case defaultCorrect
    case completeCorrect
    case maxLengthWrong
    
    var alertText: String {
        switch self {
        case .defaultCorrect:
            "교재 이름은 20글자 이내로 입력해 주세요"
        case .completeCorrect:
            "사용 가능한 이름이에요"
        case .maxLengthWrong:
            "교재 이름은 20글자 이내로 입력해 주세요"
        }
    }
}
