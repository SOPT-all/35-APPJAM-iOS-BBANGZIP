//
//  OnboardingViewModel.swift
//  BBANGZIP
//
//  Created by 김송희 on 1/20/25.
//  Copyright © 2025 com.bbangzip. All rights reserved.
//

import SwiftUI

class OnboardingViewModel: ObservableObject {
    @Published var currentState: OnboardingState
    @Published var currentStep: Step
    @Published var isForward: Bool
    @Published var buttonText: OnboardingButtonText
    @Published var year: Int
    @Published var semester: Semester
    @Published var subject: String
    @Published var subjectAnnounceState: SubjectTextFieldAlertCase?
    @Published var subjectState: TextFieldState
    @Published var nickname: String
    @Published var nicknameAnnounceState: NicknameTextFieldAlertCase?
    @Published var nicknameState: TextFieldState
    @Published var isNicknameFocused: Bool = false
    @Published var isSubjectFocused: Bool = false
    @Published var isButtonEnabled: Bool = true
    
    init(
        currentState: OnboardingState = .start,
        currentStep: Step = .first,
        isForward: Bool = true,
        buttonText: OnboardingButtonText = .start,
        year: Int = 2025,
        semester: Semester = .first,
        nickname: String = "",
        nicknameAnnounceState: NicknameTextFieldAlertCase? = .alert,
        nicknameState: TextFieldState = .defaultState,
        subject: String = "",
        subjectAnnounceState: SubjectTextFieldAlertCase? = .alert,
        subjectState: TextFieldState = .defaultState
    ) {
        self.currentState = currentState
        self.currentStep = currentStep
        self.isForward = isForward
        self.buttonText = buttonText
        self.year = year
        self.semester = semester
        self.nickname = nickname
        self.nicknameAnnounceState = nicknameAnnounceState
        self.nicknameState = nicknameState
        self.subject = subject
        self.subjectAnnounceState = subjectAnnounceState
        self.subjectState = subjectState
    }
    
    func goBack() {
        withAnimation {
            isForward = false
            
            switch currentState {
            case .nameInput:
                currentState = .start
            case .semesterInput:
                currentState = .nameInput
            case .subjectInput:
                currentState = .semesterInput
            case .complete:
                currentState = .subjectInput
            default:
                break
            }
            
            switch currentState {
            case .nameInput:
                currentStep = .first
            case .semesterInput:
                currentStep = .second
            default:
                break
            }
            
            switch currentState {
            case .start:
                buttonText = OnboardingButtonText.start
            case .nameInput, .semesterInput, .subjectInput:
                buttonText = OnboardingButtonText.inProgress
            case .complete:
                buttonText = OnboardingButtonText.complete
            }
        }
    }
    
    func goNext() {        
        withAnimation {
            isForward = true
            
            switch currentState {
            case .start, .complete:
                isButtonEnabled = false
            default:
                break
            }
            
            switch currentState {
            case .start:
                currentState = .nameInput
            case .nameInput:
                currentState = .semesterInput
            case .semesterInput:
                currentState = .subjectInput
            case .subjectInput:
                currentState = .complete
            default:
                break
            }
            
            switch currentState {
            case .nameInput:
                currentStep = .first
            case .semesterInput:
                currentStep = .second
            case .subjectInput:
                currentStep = .third
            default:
                break
            }
            
            switch currentState {
            case .start:
                buttonText = OnboardingButtonText.start
            case .nameInput, .semesterInput, .subjectInput:
                buttonText = OnboardingButtonText.inProgress
            case .complete:
                buttonText = OnboardingButtonText.complete
            }
            
            if(currentState == .start) {
                // TODO: nickname, year, semester, subjectName 서버 전달
            }
        }
    }
    
    func verifyNickname(
        oldText: String,
        newText: String,
        isNicknameFocused: Bool
    ) {
        if newText.isEmpty {
            nicknameState = .placeholder
        } else if isNicknameFocused {
            nicknameState = .typing
            if newText.containsEmoji || newText.containsSymbol {
                nicknameState = .alert
                nicknameAnnounceState = .alert
            }
        } else if !isNicknameFocused || !newText.containsEmoji  || !newText.containsSymbol {
            nicknameState = .field
            nicknameAnnounceState = .enable
            isButtonEnabled = true
        }
    
        
        if let maxLength = TextFieldStyleCase.nickname.maxLength {
            nickname = String(newText.prefix(maxLength))
        } else {
            nickname = newText
        }
    }
    
    func verifySubject(
        oldText: String,
        newText: String,
        isSubjectFocused: Bool
    ) {
        if !isSubjectFocused {
            subjectState = newText.isEmpty ? .defaultState : .field
            return
        }
        
        if newText.isEmpty {
            subjectState = .placeholder
        } else if newText.containsEmoji || newText.containsSymbol {
            subjectState = .alert
        } else {
            subjectState = .typing
        }
        
        if let maxLength = TextFieldStyleCase.subject.maxLength {
            subject = String(newText.prefix(maxLength))
        } else {
            subject = newText
        }
    }
    
    func handleNicknameFocusChange(
        isNicknameFocused: Bool,
        text: String
    ) {
        if !isNicknameFocused {
            if text.containsEmoji || text.containsSymbol {
                nicknameState = .alert
                nicknameAnnounceState = .alert
            } else if !text.containsEmoji  || !text.containsSymbol {
                nicknameState = .field
                nicknameAnnounceState = .enable
                isButtonEnabled = true
            }
        }
    }
    
    func handleSubjectFocusChange(
        isSubjectFocused: Bool,
        text: String
    ) {
        if !isSubjectFocused {
            subjectState = text.isEmpty ? .defaultState : .field
        }
    }
}
