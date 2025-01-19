//
//  NameInputViewModel.swift
//  BBANGZIP
//
//  Created by 김송희 on 1/18/25.
//  Copyright © 2025 com.bbangzip. All rights reserved.
//

import SwiftUI

final class NameInputViewModel: ObservableObject {
    @Published var currentStep: Step
    @Published var nickname: String
    @Published var announceState: NicknameTextFieldAlertCase?
    @Published var state: TextFieldState
    
    // TODO: TextField 로직 변경 후 수정 필요
    
    init(
        currentStep: Step = .first,
        nickname: String = "",
        announceState: NicknameTextFieldAlertCase? = nil,
        state: TextFieldState = .defaultState
    ) {
        self.currentStep = currentStep
        self.nickname = nickname
        self.announceState = announceState
        self.state = state
    }
    
    private func validateNickname(
        oldText: String,
        newText: String
    ) {
        if let maxLength = TextFieldStyleCase.nickname.maxLength {
            if newText.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty {
                // TODO: 공백으로만 이루어진 경우 로직 추가 필요
            }
            if newText.count > maxLength {
                nickname = String(newText.prefix(maxLength))
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
