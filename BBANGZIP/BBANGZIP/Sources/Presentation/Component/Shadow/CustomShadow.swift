//
//  CustomShadow.swift
//  BBANGZIP
//
//  Created by 최유빈 on 1/20/25.
//  Copyright © 2025 com.bbangzip. All rights reserved.
//

import SwiftUI

struct CustomShadow: ViewModifier {
    private let shadowType: Shadow
    
    init(_ shadowType: Shadow = .normal) {
        self.shadowType = shadowType
    }
    
    func body(content: Content) -> some View {
        switch shadowType {
        case .normal:
            content
                .shadow(
                    color: Color(.staticBlack).opacity(0.12),
                    radius: 2,
                    y: 2
                )
                .shadow(
                    color: Color(.staticBlack).opacity(0.08),
                    radius: 1
                )
                .shadow(
                    color: Color(.staticBlack).opacity(0.08),
                    radius: 1
                )
        case .emphasize:
            content
                .shadow(
                    color: Color(.staticBlack).opacity(0.12),
                    radius: 8,
                    y: 2
                )
                .shadow(
                    color: Color(.staticBlack).opacity(0.08),
                    radius: 4,
                    y: 1
                )
                .shadow(
                    color: Color(.staticBlack).opacity(0.08),
                    radius: 1
                )
        case .strong:
            content
                .shadow(
                    color: Color(.staticBlack).opacity(0.08),
                    radius: 8,
                    y: 4
                )
                .shadow(
                    color: Color(.staticBlack).opacity(0.12),
                    radius: 12,
                    y: 6
                )
                .shadow(
                    color: Color(.staticBlack).opacity(0.08),
                    radius: 4
                )
        case .heavy:
            content
                .shadow(
                    color: Color(.staticBlack).opacity(0.12),
                    radius: 20,
                    y: 16
                )
                .shadow(
                    color: Color(.staticBlack).opacity(0.08),
                    radius: 16,
                    y: 8
                )
                .shadow(
                    color: Color(.staticBlack).opacity(0.08),
                    radius: 8
                )
        case .normalInverse:
            content
                .shadow(
                    color: Color(.staticBlack).opacity(0.12),
                    radius: 2,
                    y: -1
                )
                .shadow(
                    color: Color(.staticBlack).opacity(0.08),
                    radius: 1
                )
                .shadow(
                    color: Color(.staticBlack).opacity(0.08),
                    radius: 1
                )
        case .emphasizeInverse:
            content
                .shadow(
                    color: Color(.staticBlack).opacity(0.12),
                    radius: 8,
                    y: -2
                )
                .shadow(
                    color: Color(.staticBlack).opacity(0.08),
                    radius: 4,
                    y: -1
                )
                .shadow(
                    color: Color(.staticBlack).opacity(0.08),
                    radius: 1
                )
        case .strongInverse:
            content
                .shadow(
                    color: Color(.staticBlack).opacity(0.12),
                    radius: 12,
                    y: -6
                )
                .shadow(
                    color: Color(.staticBlack).opacity(0.08),
                    radius: 8,
                    y: -4
                )
                .shadow(
                    color: Color(.staticBlack).opacity(0.08),
                    radius: 4
                )
        case .heavyInverse:
            content
                .shadow(
                    color: Color(.staticBlack).opacity(0.12),
                    radius: 20,
                    y: -16
                )
                .shadow(
                    color: Color(.staticBlack).opacity(0.12),
                    radius: 20,
                    y: -16
                )
                .shadow(
                    color: Color(.staticBlack).opacity(0.08),
                    radius: 16,
                    y: -8
                )
        }
    }
}

extension View {
    
    func customShadow(_ shadowType: Shadow = .normal) -> some View {
        modifier(CustomShadow(shadowType))
    }
}

