//
//  AddMotivationMessageViewModel.swift
//  BBANGZIP
//
//  Created by 최유빈 on 1/22/25.
//  Copyright © 2025 com.bbangzip. All rights reserved.
//

import SwiftUI

final class AddMotivationMessageViewModel: ObservableObject {
    @Published var message: String
    @Published var messageAnnounceState: MessageTextFieldAlertCase?
    @Published var messageState: TextFieldState
    @Published var isMessageFocused: Bool = false
    @Published var isMessageValid: Bool = false
    @Published var isButtonEnabled: Bool = false
    
    init(
        message: String = "",
        messageAnnounceState: MessageTextFieldAlertCase? = .alert,
        messageState: TextFieldState = .defaultState,
        isMessageFocused: Bool = false,
        isMessageValid: Bool = false
    ) {
        self.message = message
        self.messageAnnounceState = messageAnnounceState
        self.messageState = messageState
        self.isMessageFocused = isMessageFocused
        self.isMessageValid = isMessageValid
    }
    
    func verifyMessage(
        newText: String,
        isMessageFocused: Bool
    ) {
        validateMessageState(
            newText: newText,
            isMessageFocused: isMessageFocused
        )
    }
    
    func handleMessageFocusChange(
        newText: String,
        isMessageFocused: Bool
    ) {
        validateMessageState(
            newText: newText,
            isMessageFocused: isMessageFocused
        )
    }
    
    private func validateMessageState(
        newText: String,
        isMessageFocused: Bool
    ) {
        if !isMessageFocused {
            if newText.isEmpty {
                messageState = .defaultState  // 추가
                isMessageValid = false
            } else if newText.isMessageValid {
                messageState = .field
                messageAnnounceState = .enable
                isMessageValid = true
            } else {
                messageState = .alert
                messageAnnounceState = .alert
                isMessageValid = false
            }
        } else {
            messageState = .placeholder
            isMessageValid = false
        }
        
        isButtonEnabled = messageAnnounceState == .enable
    }
    
    func changeMotivationMessage() {
        // TODO: 동기부여 메시지 작성 및 수정 API 연동 필요
    }
}
