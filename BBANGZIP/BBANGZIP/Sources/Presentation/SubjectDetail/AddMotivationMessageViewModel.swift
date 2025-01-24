//
//  AddMotivationMessageViewModel.swift
//  BBANGZIP
//
//  Created by 최유빈 on 1/22/25.
//  Copyright © 2025 com.bbangzip. All rights reserved.
//

import SwiftUI

final class AddMotivationMessageViewModel: ObservableObject {
    private let changeNameUseCase: ChangeNameUseCase
    private let parentViewModel: SubjectDetailViewModel
    
    @Published var message: String
    @Published var messageAnnounceState: MessageTextFieldAlertCase?
    @Published var messageState: TextFieldState
    @Published var isMessageFocused: Bool = false
    @Published var isMessageValid: Bool = false
    @Published var isButtonEnabled: Bool = false
    @Published var shouldDismiss: Bool = false
    @Published var toast: Toast?
    
    init(
        changeNameUseCase: ChangeNameUseCase,
        parentViewModel: SubjectDetailViewModel,
        message: String = "",
        messageAnnounceState: MessageTextFieldAlertCase? = .alert,
        messageState: TextFieldState = .defaultState,
        isMessageFocused: Bool = false,
        isMessageValid: Bool = false
    ) {
        self.changeNameUseCase = changeNameUseCase
        self.parentViewModel = parentViewModel
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
    
    @MainActor
    func changeMotivationMessage() async {
        do {
            let _: () = try await changeNameUseCase.execute(
                subjectId: parentViewModel.subjectId,
                options: "motivationMessage",
                value: message
            )
            
            await parentViewModel.fetchData()
                    
            parentViewModel.toast = Toast(
                "각오 한 마디 작성 완료!",
                startFrom: 20
            )
                    
            self.shouldDismiss = true
            
        } catch {
            dump(error)
            print(error)
        }
    }
}
