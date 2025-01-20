//
//  OnboardingView.swift
//  BBANGZIP
//
//  Created by 김송희 on 1/20/25.
//  Copyright © 2025 com.bbangzip. All rights reserved.
//

import SwiftUI

enum OnboardingButtonText {
    case start
    case inProgress
    case complete
    
    var text: String {
        switch self {
        case .start: "빵집 오픈하러 가기"
        case .inProgress: "다음으로"
        case .complete: "빵점 탈출하러 가기"
        }
    }
}

struct OnboardingView: View {
    @State private var currentState: OnboardingState = .start
    @State private var currentStep: Step = .first
    @State private var isForward: Bool = true
    @State private var buttonText: OnboardingButtonText = .start
    
    var body: some View {
        NavigationStack {
            switch currentState {
            case .start:
                VStack {
                    OnboardingStartView()
                    
                    nextButton
                }
            case .complete:
                VStack {
                    backButton
                    
                    OnboardingCompleteView()
                    
                    nextButton
                }
            default:
                VStack {
                    backButton
                    
                    progressBar
                    
                    inputView
                    
                    nextButton
                }
            }
        }
    }
    
    private var backButton: some View {
        Button(action: goBack) {
            Image(.chevronLeftThickSmall)
                .renderingMode(.template)
                .foregroundStyle(Color(.labelAlternative))
            Spacer()
        }
        .padding(16)
    }
    
    private var progressBar: some View {
        ProgressBar(category: $currentStep)
            .padding(
                .horizontal,
                44
            )
            .padding(
                .bottom,
                78
            )
    }
    
    private var nextButton: some View {
        Button(buttonText.text, action: goNext)
            .buttonStyle(
                SolidIconButton(
                    buttonImage: Image(.chevronRight)
                )
            )
            .padding(.horizontal, 20)
    }
    
    @ViewBuilder
    private var inputView: some View {
            ZStack {
                if currentState == .nameInput {
                    NameInputView()
                        .transition(.move(edge: .leading))
                } else if currentState == .semesterInput {
                    SemesterInputView()
                        .transition(
                            .asymmetric(
                                insertion: .move(edge: isForward ? .trailing : .leading),
                                removal: .move(edge: isForward ? .leading : .trailing)
                            )
                        )
                } else if currentState == .subjectInput {
                    SubjectInputView()
                        .transition(.move(edge: .trailing))
                }
            }
            .animation(.easeInOut, value: currentState)
    }

    private func goBack() {
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
    
    private func goNext() {
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
        }
    }
}

#Preview {
    OnboardingView()
}
