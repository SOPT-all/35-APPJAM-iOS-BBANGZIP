//
//  Environment.swift
//  BBANGZIP
//
//  Created by 송여경 on 1/15/25.
//  Copyright © 2025 com.bbangzip. All rights reserved.
//

import Foundation

enum Environment {
    static let baseURL: String = Bundle.main.infoDictionary?["BASE_URL"] as! String
}
