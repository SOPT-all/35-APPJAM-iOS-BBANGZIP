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
    @Published var nickname: String
    @Published var year: Int
    @Published var semester: Semester
    @Published var subject: String
    
    init(
        currentState: OnboardingState = .start,
        currentStep: Step = .first,
        isForward: Bool = true,
        buttonText: OnboardingButtonText = .start,
        nickname: String = "",
        year: Int = 2025,
        semester: Semester = .first,
        subject: String = ""
    ) {
        self.currentState = currentState
        self.currentStep = currentStep
        self.isForward = isForward
        self.buttonText = buttonText
        self.nickname = nickname
        self.year = year
        self.semester = semester
        self.subject = subject
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
    
}
