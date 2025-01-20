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
    @StateObject private var viewModel: OnboardingViewModel
    
    init(
        viewModel: OnboardingViewModel = OnboardingViewModel()
    ) {
        _viewModel = StateObject(wrappedValue: viewModel)
    }
    
    var body: some View {
        NavigationStack {
            switch viewModel.currentState {
            case .start:
                VStack(spacing: 0) {
                    OnboardingStartView()
                    
                    nextButton
                }
            case .complete:
                VStack(spacing: 0) {
                    backButton
                    
                    OnboardingCompleteView()
                    
                    nextButton
                }
            default:
                VStack(spacing: 0) {
                    backButton
                    
                    progressBar
                    
                    inputView
                    
                    nextButton
                }
                .ignoresSafeArea(.keyboard)
            }
        }
        .onTapGesture {
            hideKeyboard()
        }
    }
    
    private var backButton: some View {
        Button(action: viewModel.goBack) {
            Image(.chevronLeftThickSmall)
                .renderingMode(.template)
                .foregroundStyle(Color(.labelAlternative))
            Spacer()
        }
        .padding(16)
    }
    
    private var progressBar: some View {
        ProgressBar(type: .withCircle(category: viewModel.currentStep))
            .padding(
                .horizontal,
                44
            )
            .padding(
                .bottom,
                48
            )
    }
    
    private var nextButton: some View {
        Button(
            viewModel.buttonText.text,
            action: viewModel.goNext
        )
            .buttonStyle(
                SolidIconButton(
                    buttonImage: Image(.chevronRightThickSmall),
                    viewModel.isButtonEnabled
                )
            )
            .disabled(!viewModel.isButtonEnabled)
            .padding(.horizontal, 20)
    }
    
    @ViewBuilder
    private var inputView: some View {
        ZStack {
            if viewModel.currentState == .nameInput {
                NameInputView(nickname: $viewModel.nickname)
                    .transition(.move(edge: .leading))
            } else if viewModel.currentState == .semesterInput {
                SemesterInputView(
                    nickname: $viewModel.nickname,
                    selectedYear: $viewModel.year,
                    selectedSemester: $viewModel.semester
                )
                .transition(
                    .asymmetric(
                        insertion: .move(edge: viewModel.isForward ? .trailing : .leading),
                        removal: .move(edge: viewModel.isForward ? .leading : .trailing)
                    )
                )
            } else if viewModel.currentState == .subjectInput {
                SubjectInputView(
                    subject: $viewModel.subject,
                    selectedYear: $viewModel.year,
                    selectedSemester: $viewModel.semester
                )
                .transition(.move(edge: .trailing))
            }
        }
        .animation(
            .easeInOut,
            value: viewModel.currentState
        )
    }
}

#Preview {
    OnboardingView()
}
