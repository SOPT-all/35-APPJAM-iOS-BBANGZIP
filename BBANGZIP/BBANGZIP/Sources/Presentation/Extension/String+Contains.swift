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
    
    var containsNumber: Bool {
        self.range(
            of: "\\d",
            options: .regularExpression
        ) != nil
    }
    
    var containsKorean: Bool {
        self.range(
            of: "[가-힣]",
            options: .regularExpression
        ) != nil
    }
    
    var containsEnglish: Bool {
        self.range(
            of: "[a-zA-Z]",
            options: .regularExpression
        ) != nil
    }
    
    var isValidNickname: Bool {
        let regex = "^[가-힣ㄱ-ㅎㅏ-ㅣa-zA-Z0-9]{1,10}$"
        return self.range(of: regex, options: .regularExpression) != nil
    }
}
