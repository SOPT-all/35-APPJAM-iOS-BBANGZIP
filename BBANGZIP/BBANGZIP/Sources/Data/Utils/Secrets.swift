//
//  SecretManager.swift
//  BBANGZIP
//
//  Created by 송여경 on 1/19/25.
//  Copyright © 2025 com.bbangzip. All rights reserved.
//

import Foundation

enum Secrets {
    static let kakao: String = Bundle.main.infoDictionary?["KAKAO_NATIVE_APP_KEY"] as! String
}
