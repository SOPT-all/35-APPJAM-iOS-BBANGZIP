//
//  SubjectAddViewModel.swift
//  BBANGZIP
//
//  Created by 최유빈 on 1/19/25.
//  Copyright © 2025 com.bbangzip. All rights reserved.
//

import SwiftUI

class SubjectAddViewModel: ObservableObject {
    @Published var subject: String
    @Published var state: TextFieldState
    @Published var alertCase: SubjectTextFieldAlterCase?
    @Published var isEnabled: Bool
    
    init(
        subject: String = "",
        state: TextFieldState = .defaultState,
        alertCase: SubjectTextFieldAlterCase? = .defaultCorrect,
        isEnabled: Bool = false
    ) {
        self.subject = subject
        self.state = state
        self.alertCase = alertCase
        self.isEnabled = isEnabled
    }
    
    // TODO: 텍스트필드 조건 만족시 isEnabled = true로 변경하는 로직 필요
    private func validateSubject(
        oldText: String,
        newText: String
    ) {
        if let maxLength = TextFieldStyleCase.subject.maxLength {
            if newText.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty {
                // TODO: 공백으로만 이루어진 경우 로직 필요
            }
            if newText.count > maxLength {
                subject = String(newText.prefix(maxLength))
                state = .alert
                alertCase = .maxLengthWrong
            } else {
                var result = newText
                
                for char in oldText {
                    if let index = result.firstIndex(of: char) {
                        result.remove(at: index)
                    }
                }
                
                if result.isEmpty {
                    // TODO: 공백인 경우 로직 추가 필요
                } else {
                    if result.containsEmoji {
                        state = .alert
                        alertCase = .emojiWrong
                    } else if result.containsSymbol {
                        state = .alert
                        alertCase = .symbolWrong
                    } else {
                        if newText.isEmpty {
                            state = .placeholder
                            alertCase = .defaultCorrect
                        } else {
                            state = .complete
                            alertCase = .completeCorrect
                        }
                    }
                }
            }
        }
    }
    
    func addSubject() {
        // TODO: 과목 추가, 과목 중복 비교 로직 / 토스트 메시지 노출 로직 구현 필요
    }
}