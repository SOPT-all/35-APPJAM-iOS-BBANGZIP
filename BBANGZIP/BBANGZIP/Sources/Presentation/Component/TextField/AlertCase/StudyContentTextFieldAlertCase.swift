//
//  StudyContentTextFieldAlertCase.swift
//  BBANGZIP
//
//  Created by 김송희 on 1/20/25.
//  Copyright © 2025 com.bbangzip. All rights reserved.
//

import SwiftUI

enum StudyContentTextFieldAlertCase: TextFieldAlertable {
    case alert
    case enable
    
    var alertText: String {
        switch self {
        case .alert:
            "한글/영문/숫자/기호 조합으로 최대 20자까지 입력 가능해요"
        case .enable:
            "사용 가능한 교재/PPT 이름이에요"
        }
    }
}
