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
    @Published var isNicknameValid: Bool = false
    
    init(
        currentState: OnboardingState = .start,
        currentStep: Step = .first,
        isForward: Bool = true,
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
        }
    }
    
    func goNext() {
        withAnimation {
            isForward = true
            
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
            
            if(currentState == .start) {
                // TODO: nickname, year, semester, subjectName 서버 전달
            }
        }
    }
    
    // TODO: 텍스트필드 focused 되고 입력 없으면 placeholer로 상태 처리하는 로직 필요
    // TODO: 텍스트 앞뒤에 공백 입력될 시 자동으로 제거되는 로직 필요
    func verifyNickname(
        newText: String,
        isNicknameFocused: Bool
    ) {
        // textfield가 눌린 상태
        if isNicknameFocused {
            nicknameState = .typing
            
            // 눌렸는데 비어 있으면 (X 누르면)
            if newText.isEmpty {
                nicknameState = .defaultState
                nicknameAnnounceState = .alert
                isNicknameValid = false
            } else { // 눌렸는데 안 비어있으면
                if newText.isValidNickname { // 규칙 맞으면
                    nicknameState = .typing
                    nicknameAnnounceState = .enable
                    isNicknameValid = true
                } else { // 규칙 안 맞으면
                    nicknameState = .alert
                    nicknameAnnounceState = .alert
                    isNicknameValid = false
                }
            }
        } else if newText.isEmpty { // 안 눌렸는데 비어 있으면 (초기 상태)
            nicknameState = .defaultState
            nicknameAnnounceState = .alert
            isNicknameValid = false
        }
    }
    
    // TODO: verifyNickname 로직 완성 후 subject도 전면 수정 필요
    func verifySubject(
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
        newText: String,
        isNicknameFocused: Bool
    ) {
        if !isNicknameFocused {
            if newText.isEmpty {
                nicknameState = .defaultState
                isNicknameValid = false
            } else if newText.isValidNickname { // 규칙 맞으면
                nicknameState = .field
                nicknameAnnounceState = .enable
                isNicknameValid = true
            } else { // 규칙 안 맞으면
                nicknameState = .alert
                nicknameAnnounceState = .alert
                isNicknameValid = false
            }
        } else {
            nicknameState = .placeholder
            isNicknameValid = false
        }
    }
    
    // TODO: handleNicknameForcusChange 로직 완성 후 subject도 전면 수정 필요
    func handleSubjectFocusChange(
        isSubjectFocused: Bool,
        text: String
    ) {
        if !isSubjectFocused {
            subjectState = text.isEmpty ? .defaultState : .field
        }
    }
}
