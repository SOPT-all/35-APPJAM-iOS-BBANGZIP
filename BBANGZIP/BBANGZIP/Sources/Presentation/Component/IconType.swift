//
//  IconType.swift
//  BBANGZIP
//
//  Created by 송여경 on 1/15/25.
//  Copyright © 2025 com.bbangzip. All rights reserved.
//

import SwiftUI

enum IconType {
    case black
    case yellow
    case orange
    
    var color: Color {
        switch self {
        case .black:
            return BBANGZIPAsset.Assets.statusPositive.swiftUIColor
        case .yellow:
            return BBANGZIPAsset.Assets.statusCautionary.swiftUIColor
        case .orange:
            return BBANGZIPAsset.Assets.statusDestructive.swiftUIColor
        }
    }
}
