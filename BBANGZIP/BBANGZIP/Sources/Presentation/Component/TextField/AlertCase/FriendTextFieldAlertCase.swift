//
//  FriendTextFieldAlertCase.swift
//  BBANGZIP
//
//  Created by 김송희 on 1/25/25.
//

import SwiftUI

enum FriendTextFieldAlertCase: TextFieldAlertable {
        case alert
        
        var alertText: String {
            switch self {
            case .alert:
                "8자리 이내, 문자/숫자/영문 가능, 특수문자/기호 입력불가"
            }
        }
    }
