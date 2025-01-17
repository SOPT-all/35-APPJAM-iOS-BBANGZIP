//
//  String+.swift
//  BBANGZIP
//
//  Created by 조성민 on 1/17/25.
//  Copyright © 2025 com.bbangzip. All rights reserved.
//

extension String {
    var containsEmoji: Bool {
        self.unicodeScalars.contains(where: { $0.properties.isEmojiPresentation })
    }
    var containsSymbol: Bool {
        self.range(
            of: "\\p{Symbol}",
            options: .regularExpression
        ) != nil ||
        self.range(
            of: "\\p{Punctuation}",
            options: .regularExpression
        ) != nil
    }
}
