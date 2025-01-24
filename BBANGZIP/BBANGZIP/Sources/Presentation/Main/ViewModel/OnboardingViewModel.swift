//
//  OnboardingViewModel.swift
//  BBANGZIP
//
//  Created by 김송희 on 1/20/25.
//  Copyright © 2025 com.bbangzip. All rights reserved.
//

import SwiftUI

final class OnboardingViewModel: ObservableObject {
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
    @Published var isSemesterValid: Bool = true
    @Published var isSubjectValid: Bool = false
    @Published var navigateToCustomTabView: Bool = false
    
    private let onboardingUseCase: OnboardingUseCase
    
    init(
        onboardingUseCase: OnboardingUseCase,
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
        self.onboardingUseCase = onboardingUseCase
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
            case .nameInput:
                nickname = nickname.trimmingCharacters(in: .whitespaces)
            case .subjectInput:
                subject = subject.trimmingCharacters(in: .whitespaces)
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
        }
    }
    
    func verifyNickname(
        newText: String,
        isNicknameFocused: Bool
    ) {
        if isNicknameFocused {
            nicknameState = .typing
            
            if newText.isEmpty {
                nicknameState = .defaultState
                nicknameAnnounceState = .alert
                isNicknameValid = false
            } else {
                if newText.isValidNickname {
                    nicknameState = .typing
                    nicknameAnnounceState = .enable
                    isNicknameValid = true
                } else {
                    nicknameState = .alert
                    nicknameAnnounceState = .alert
                    isNicknameValid = false
                }
            }
        } else if newText.isEmpty {
            nicknameState = .defaultState
            nicknameAnnounceState = .alert
            isNicknameValid = false
        }
    }
    
    func verifySemester() {
        if year == 2025 && semester == .first {
            isSemesterValid = true
        } else {
            isSemesterValid = false
        }
    }
    
    func verifySubject(
        newText: String,
        isSubjectFocused: Bool
    ) {
        if isSubjectFocused {
            subjectState = .typing
            
            if newText.isEmpty {
                subjectState = .defaultState
                subjectAnnounceState = .alert
                isSubjectValid = false
            } else {
                if newText.isValidSubject {
                    subjectState = .typing
                    subjectAnnounceState = .enable
                    isSubjectValid = true
                } else {
                    subjectState = .alert
                    subjectAnnounceState = .alert
                    isSubjectValid = false
                }
            }
        } else if newText.isEmpty {
            subjectState = .defaultState
            subjectAnnounceState = .alert
            isSubjectValid = false
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
            } else if newText.isValidNickname {
                nicknameState = .field
                nicknameAnnounceState = .enable
                isNicknameValid = true
            } else {
                nicknameState = .alert
                nicknameAnnounceState = .alert
                isNicknameValid = false
            }
        } else {
            nicknameState = .placeholder
            isNicknameValid = false
        }
    }
    
    func handleSubjectFocusChange(
        newText: String,
        isSubjectFocused: Bool
    ) {
        if !isSubjectFocused {
            if newText.isEmpty {
                subjectState = .defaultState
                isSubjectValid = false
            } else if newText.isValidSubject {
                subjectState = .field
                subjectAnnounceState = .enable
                isSubjectValid = true
            } else {
                subjectState = .alert
                subjectAnnounceState = .alert
                isSubjectValid = false
            }
        } else {
            subjectState = .placeholder
            isSubjectValid = false
        }
    }
    
    @MainActor
    func onboard() async {
        do{
            try await onboardingUseCase.execute(
                nickname: nickname,
                year: year,
                semester: semester.rawValue,
                subjectName: subject
            )
            navigateToCustomTabView = true
        } catch {
            print("Error during onboarding: \(error)")
        }
    }
}

