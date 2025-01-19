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
    @Published var announceState: SubjectTextFieldAlterCase?
    @Published var state: TextFieldState
    
    init(
        subject: String = "",
        announceState: SubjectTextFieldAlterCase? = nil,
        state: TextFieldState = .defaultState
    ) {
        self.subject = subject
        self.announceState = announceState
        self.state = state
    }
    
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
                announceState = .maxLengthWrong
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
                        announceState = .emojiWrong
                    } else if result.containsSymbol {
                        state = .alert
                        announceState = .symbolWrong
                    } else {
                        if newText.isEmpty {
                            state = .placeholder
                            announceState = .defaultCorrect
                        } else {
                            state = .complete
                            announceState = .completeCorrect
                        }
                    }
                }
            }
        }
    }
}
