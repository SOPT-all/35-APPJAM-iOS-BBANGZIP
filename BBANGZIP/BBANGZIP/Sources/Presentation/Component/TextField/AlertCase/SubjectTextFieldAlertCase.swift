//
//  SubjectTextFieldAlertCase.swift
//  BBANGZIP
//
//  Created by 김송희 on 1/20/25.
//  Copyright © 2025 com.bbangzip. All rights reserved.
//

import SwiftUI

enum SubjectTextFieldAlertCase: TextFieldAlertable {
    case alert
    case enable
    
    var alertText: String {
        switch self {
        case .alert:
            "한글/영문/숫자 조합으로 최대 10자까지 입력 가능해요"
        case .enable:
            "사용 가능한 이름이에요"
        }
    }
}
