//
//  OnboardingView.swift
//  BBANGZIP
//
//  Created by 김송희 on 1/20/25.
//  Copyright © 2025 com.bbangzip. All rights reserved.
//

import SwiftUI

struct OnboardingView: View {
    @State private var currentState: OnbordingState = .nameInput
    @State private var currentStep: Step = .first
    @State private var isForward: Bool = true
    
    var body: some View {
        NavigationStack {
            VStack {
                backButton
                
                progressBar
                
                mainView
                
                nextButton
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
        Button("다음으로", action: goNext)
            .buttonStyle(
                SolidIconButton(
                    buttonImage: Image(.chevronRight)
                )
            )
            .padding(.horizontal, 20)
    }
    
    @ViewBuilder
    private var mainView: some View {
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
        isForward = false
        
        withAnimation {
            switch currentState {
            case .nameInput:
                break
            case .semesterInput:
                currentState = .nameInput
            case .subjectInput:
                currentState = .semesterInput
            }
            
            switch currentState {
            case .nameInput:
                currentStep = .first
            case .semesterInput:
                currentStep = .second
            case .subjectInput:
                break
            }
        }
    }
    
    private func goNext() {
        isForward = true
        
        withAnimation {
            switch currentState {
            case .nameInput:
                currentState = .semesterInput
            case .semesterInput:
                currentState = .subjectInput
            case .subjectInput:
                break
            }
            
            switch currentState {
            case .nameInput:
                currentStep = .first
            case .semesterInput:
                currentStep = .second
            case .subjectInput:
                currentStep = .third
            }
        }
    }
}

#Preview {
    OnboardingView()
}
