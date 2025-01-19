//
//  CardState.swift
//  BBANGZIP
//
//  Created by 조성민 on 1/17/25.
//  Copyright © 2025 com.bbangzip. All rights reserved.
//

import SwiftUI

protocol CardState {
    var backgroundColor: Color { get }
    var borderColor: Color { get }
    var borderWidth: CGFloat { get }
}
