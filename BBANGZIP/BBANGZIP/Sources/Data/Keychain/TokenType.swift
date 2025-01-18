//
//  TokenType.swift
//  BBANGZIP
//
//  Created by 송여경 on 1/19/25.
//  Copyright © 2025 com.bbangzip. All rights reserved.
//

import Foundation

enum TokenType {
    case AccessToken
    case RefreshToken
    
    var account: String {
        switch self {
        case .AccessToken:
            "accessToken"
        case .RefreshToken:
            "refreshToken"
        }
    }
}
