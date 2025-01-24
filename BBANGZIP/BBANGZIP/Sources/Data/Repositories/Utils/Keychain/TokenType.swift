//
//  TokenType.swift
//  BBANGZIP
//
//  Created by 송여경 on 1/23/25.
//  Copyright © 2025 com.bbangzip. All rights reserved.
//

import Foundation

public enum TokenType {
  case AccessToken
  case RefreshToken
  
  public var account: String {
    switch self {
    case .AccessToken:
      "accessToken"
    case .RefreshToken:
      "refreshToken"
    }
  }
}
