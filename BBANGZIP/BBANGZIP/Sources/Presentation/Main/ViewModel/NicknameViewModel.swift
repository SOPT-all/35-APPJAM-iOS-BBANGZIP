//
//  NicknameViewModel.swift
//  BBANGZIP
//
//  Created by 김송희 on 1/21/25.
//  Copyright © 2025 com.bbangzip. All rights reserved.
//

import SwiftUI

class NicknameViewModel: ObservableObject {
    @Published var nickname: String
    @Published var nicknameAnnounceState: NicknameTextFieldAlertCase?
    @Published var nicknameState: TextFieldState
    @Published var inFocused: Bool = false
    
    init(
        nickname: String = "",
        nicknameAnnounceState: NicknameTextFieldAlertCase? = .alert,
        nicknameState: TextFieldState = .defaultState
    ) {
        self.nickname = nickname
        self.nicknameAnnounceState = nicknameAnnounceState
        self.nicknameState = nicknameState
    }
    
    func verifyNickname(
        oldText: String,
        newText: String,
        isFocused: Bool
    ) {
        if !isFocused {
            nicknameState = newText.isEmpty ? .defaultState : .field
            return
        }
        
        if newText.isEmpty {
            nicknameState = .placeholder
        } else if newText.containsEmoji || newText.containsSymbol {
            nicknameState = .alert
        } else {
            nicknameState = .typing
        }
        
        if let maxLength = TextFieldStyleCase.nickname.maxLength {
            nickname = String(newText.prefix(maxLength))
        } else {
            nickname = newText
        }
    }
    
    func handleFocusChange(isFocused: Bool, text: String) {
        if !isFocused {
            nicknameState = text.isEmpty ? .defaultState : .field
        }
    }
}
