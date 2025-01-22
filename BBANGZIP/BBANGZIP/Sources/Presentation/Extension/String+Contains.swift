//
//  String+.swift
//  BBANGZIP
//
//  Created by 조성민 on 1/17/25.
//  Copyright © 2025 com.bbangzip. All rights reserved.
//

extension String {
    var isValidNickname: Bool {
        let trimmedText = self.trimmingCharacters(in: .whitespacesAndNewlines)
        let regex = "^[가-힣ㄱ-ㅎㅏ-ㅣa-zA-Z0-9\\s]{1,10}$"
        return !trimmedText.isEmpty && trimmedText.range(
            of: regex,
            options: .regularExpression
        ) != nil
    }
    
    var isValidSubject: Bool {
        let trimmedText = self.trimmingCharacters(in: .whitespacesAndNewlines)
        let regex = "^[가-힣ㄱ-ㅎㅏ-ㅣa-zA-Z0-9\\s]{1,10}$"
        return !trimmedText.isEmpty && trimmedText.range(
            of: regex,
            options: .regularExpression
        ) != nil
    }
}
