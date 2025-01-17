//
//  NicknameTextFieldAlertCase.swift
//  BBANGZIP
//
//  Created by 조성민 on 1/17/25.
//  Copyright © 2025 com.bbangzip. All rights reserved.
//

enum NicknameTextFieldAlertCase: TextFieldAlertable {
    case defaultCorrect
    case completeCorrect
    case maxLengthWrong
    case emojiWrong
    case symbolWrong
    case onlySpaceWrong
    case spaceSideWrong
    
    var alertText: String {
        switch self {
        case .defaultCorrect:
            "10자리 이내, 문자/숫자/영문 가능, 특수문자/기호 입력불가"
        case .completeCorrect:
            "사용 가능한 이름이에요"
        case .maxLengthWrong:
            "이름은 8자리 이내로 설정해주세요"
        case .emojiWrong:
            "이름에는 특수문자를 사용할 수 없어요"
        case .symbolWrong:
            "이름에는 기호를 사용할 수 없어요"
        case .onlySpaceWrong:
            "이름에는 공백만 사용할 수 없어요"
        case .spaceSideWrong:
            "이름 앞, 뒤에는 공백을 사용할 수 없어요"
        }
    }
}
