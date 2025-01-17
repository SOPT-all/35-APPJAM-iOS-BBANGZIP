//
//  NameInputViewModel.swift
//  BBANGZIP
//
//  Created by 김송희 on 1/18/25.
//  Copyright © 2025 com.bbangzip. All rights reserved.
//

import SwiftUI

class NameInputViewModel: ObservableObject {
    @Published var currentStep: Step = .First
    @Published var nickname: String = ""
    @Published var announceState: NicknameTextFieldAlertCase? = nil
    @Published var state: TextFieldState = .defaultState
    
    func handleNextButtonTapped() {
        // TODO: 다음 버튼 눌렀을 때 화면 전환 로직 구현
    }
    
    private func validateNickname(oldText: String, newText: String) {
        if let maxLength = TextFieldStyleCase.nickname.maxLength {
            if newText.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty {
                // 공백으로만 이루어짐
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
                
                if result.isEmpty { // 글자 삭제한 경우
                    
                } else { // 입력한 글자 검사
                    if result.containsEmoji { // 특수문자(이모지)
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
