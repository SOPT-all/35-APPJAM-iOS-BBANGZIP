//
//  MessageTextFieldAlertCase.swift
//  BBANGZIP
//
//  Created by 최유빈 on 1/22/25.
//  Copyright © 2025 com.bbangzip. All rights reserved.
//

enum MessageTextFieldAlertCase: TextFieldAlertable {
    case alert
    case enable
    
    var alertText: String {
        switch self {
        case .alert:
            "한글/영문/숫자/기호 조합으로 최대 25자까지 입력 가능해요."
        case .enable:
            ""
        }
    }
}
