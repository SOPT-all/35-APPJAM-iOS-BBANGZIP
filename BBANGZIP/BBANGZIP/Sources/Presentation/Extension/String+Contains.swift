//
//  String+.swift
//  BBANGZIP
//
//  Created by 조성민 on 1/17/25.
//  Copyright © 2025 com.bbangzip. All rights reserved.
//

extension String {
    var isValidStudyContent: Bool {
        let trimmedText = self.trimmingCharacters(in: .whitespacesAndNewlines)
        let regex = "^[가-힣ㄱ-ㅎㅏ-ㅣa-zA-Z0-9\\s\\p{P}\\p{S}]{1,20}$"
        
        guard !trimmedText.isEmpty,
              trimmedText.range(
                of: regex,
                options: .regularExpression
              ) != nil else {
            return false
        }
        
        return !trimmedText.unicodeScalars.contains { $0.properties.isEmojiPresentation }
    }
    
    var isValidStudyRange: Bool {
        let regex = "^\\d{1,4}p?$"
        return self.range(
            of: regex,
            options: .regularExpression
        ) != nil
    }
    
    func trimmingLeadingZeros() -> String {
        guard let intValue = Int(self) else { return self }
        return String(intValue)
    }
}
