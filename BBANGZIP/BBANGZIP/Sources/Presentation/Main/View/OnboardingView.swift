//
//  OnboardingView.swift
//  BBANGZIP
//
//  Created by 김송희 on 1/20/25.
//  Copyright © 2025 com.bbangzip. All rights reserved.
//

import SwiftUI

struct OnboardingView: View {
    @ObservedObject private var viewModel: OnboardingViewModel
    @Binding private var isOnboardingComplete: Bool
    
    // Focus
    @FocusState var isNicknameFocused: Bool
    @FocusState var isSubjectFocused: Bool
    
    init(
        viewModel: OnboardingViewModel,
        isOnboardingComplete: Binding<Bool>
    ) {
        self.viewModel = viewModel
        _isOnboardingComplete = isOnboardingComplete
    }
    
    var body: some View {
        VStack(spacing: 0) {
            switch viewModel.stage {
            case .start:
                firstView
            case .nickname:
                backButton
                progressBar
                nameInputView
            case .semester:
                backButton
                progressBar
                semesterInputView
            case .subject:
                backButton
                progressBar
                subjectInputView
            case .end:
                backButton
                finishView
            }
            
            nextButton
        }
        .background(Color(.staticWhite))
        .onChange(of: viewModel.isOnboardingComplete) { newValue in
            isOnboardingComplete = newValue
        }
        .onTapGesture {
            hideKeyboard()
        }
    }
    
    private var firstView: some View {
        ZStack {
            Image(.onboarding)
                .frame(
                    width: 320,
                    height: 360
                )
                .padding(
                    .top,
                    44
                )
            
            Spacer()
            
            VStack {
                HStack {
                    CustomText(
                        "제 과제 빵점에 오신 것을\n환영합니다!",
                        fontType: .title2Bold,
                        color: Color(.labelNormal)
                    )
                    .padding(
                        .top,
                        121
                    )
                    .padding(
                        .bottom,
                        36
                    )
                    
                    Spacer()
                }
                
                Spacer()
            }
            .padding(
                .horizontal,
                20
            )
        }
    }
    
    private var nextButton: some View {
        Button {
            Task {
                await viewModel.goNextStage()
            }
        } label: {
            Text(viewModel.stage.buttonTitle)
        }
        .buttonStyle(
            SolidIconButton(
                buttonImage: Image(.chevronRightThickSmall),
                !viewModel.isNextButtonDisabled
            )
        )
        .disabled(viewModel.isNextButtonDisabled)
        .padding(
            .horizontal,
            20
        )
    }
    private var backButton: some View {
        Button(action: viewModel.goPrevStage) {
            Image(.chevronLeftThickSmall)
                .renderingMode(.template)
                .foregroundStyle(Color(.labelAlternative))
            Spacer()
        }
        .padding(16)
    }
    
    private var progressBar: some View {
        ProgressBar(
            type: .withCircle(
                category: viewModel.progressBarStep
            )
        )
        .padding(
            .horizontal,
            44
        )
        .padding(
            .bottom,
            48
        )
    }
    
    private var nameInputView: some View {
        VStack(spacing: 32) {
            nameMainDescription
            
            nicknameTextField
            
            Spacer()
        }
        .padding(
            .horizontal,
            20
        )
    }
    private var nameMainDescription: some View {
        HStack {
            CustomText(
                "사장님의 이름을\n알려주세요",
                fontType: .title2Bold,
                color: Color(.labelNormal)
            )
            .padding(
                .top,
                30
            )
            
            Spacer()
        }
    }
    private var nicknameTextField: some View {
        TextField(
            "예) 탁구왕김제빵",
            text: $viewModel.nickname
        )
        .focused($isNicknameFocused)
        .textFieldStyle(
            CustomTextFieldStyle(
                text: $viewModel.nickname,
                style: .nickname,
                state: viewModel.nicknameTextFieldState,
                alertText: viewModel.nicknameTextFieldAlertCase
            )
        )
        .onChange(of: isNicknameFocused) { newValue in
            viewModel.setNicknameState(isNicknameFocused: newValue)
        }
        .onChange(of: viewModel.nickname) { [nickname = viewModel.nickname] newNickname in
            viewModel.handleNickname(
                oldNickname: nickname,
                newNickname: newNickname
            )
        }
    }
    
    private var semesterInputView: some View {
        VStack(spacing: 0) {
            VStack(spacing: 0) {
                semesterHeaderDescription
                semesterMainDescription
                
                HStack(spacing: 0) {
                    yearPicker
                    semesterPicker
                }
                
                Spacer()
            }
            .padding(.horizontal, 20)
        }
    }
    private var semesterHeaderDescription: some View {
        HStack {
            CustomText(
                "\(viewModel.nickname) 사장님, 안녕하세요!",
                fontType: .body2Bold,
                color: Color(.labelAlternative)
            )
            Spacer()
        }
        .padding(.bottom, 8)
    }
    private var semesterMainDescription: some View {
        HStack {
            CustomText(
                "현재 재학 중인\n학기를 알려주세요",
                fontType: .title2Bold,
                color: Color(.labelNormal)
            )
            Spacer()
        }
        .padding(.bottom, 32)
    }
    private var yearPicker: some View {
        Picker(
            "Year",
            selection: $viewModel.year
        ) {
            ForEach(
                [
                    2025,
                    2026,
                    2027,
                    2028
                ],
                id: \.self
            ) { year in
                CustomText(
                    "\(year)년",
                    fontType: .heading2Bold,
                    color: Color(.labelStrong)
                )
                .tag(year)
            }
        }
        .pickerStyle(WheelPickerStyle())
        .onChange(of: viewModel.year) { _ in
            viewModel.validateNextButton()
        }
        .padding(
            .leading,
            -5
        )
        .padding(
            .trailing,
            -15
        )
        .clipped()
    }
    private var semesterPicker: some View {
        Picker(
            "Semester",
            selection: $viewModel.semester
        ) {
            ForEach(
                Semester.allCases,
                id: \.self
            ) { semester in
                CustomText(
                    semester.rawValue,
                    fontType: .heading2Bold,
                    color: Color(.labelStrong)
                )
                .tag(semester)
            }
        }
        .pickerStyle(WheelPickerStyle())
        .onChange(of: viewModel.semester) { _ in
            viewModel.validateNextButton()
        }
        .padding(.leading, -15)
        .padding(.trailing, -5)
        .clipped()
    }
    
    private var subjectInputView: some View {
        VStack(spacing: 0) {
            subjectHeaderDescription
            subjectMainDescription
            subjectTextField
            Spacer()
        }
        .padding(.horizontal, 20)
    }
    private var subjectHeaderDescription: some View {
        HStack(spacing: 0) {
            CustomText(
                "\(viewModel.year)년 \(viewModel.semester.rawValue)에 재학 중이시네요!",
                fontType: .body2Bold,
                color: Color(.labelAlternative)
            )
            Spacer()
        }
        .padding(.bottom, 8)
    }
    private var subjectMainDescription: some View {
        HStack(spacing: 0) {
            CustomText(
                "수강하는 과목 중\n한 가지만 먼저 입력해 볼까요?",
                fontType: .title2Bold,
                color: Color(.labelNormal)
            )
            Spacer()
        }
        .padding(.bottom, 33)
    }
    
    private var subjectTextField: some View {
        TextField(
            "예) 거시경제학",
            text: $viewModel.subject
        )
        .focused($isSubjectFocused)
        .textFieldStyle(
            CustomTextFieldStyle(
                text: $viewModel.subject,
                style: .subject,
                state: viewModel.subjectTextFieldState,
                alertText: viewModel.subjectTextFieldAlertCase
            )
        )
        .onChange(of: isSubjectFocused) { newValue in
            viewModel.setSubjectState(isSubjectFocused: newValue)
        }
        .onChange(of: viewModel.subject) { [subject = viewModel.subject] newSubject in
            viewModel.handleSubject(
                oldSubject: subject,
                newSubject: newSubject
            )
        }
    }
    
    private var finishView: some View {
        ZStack {
            Image(.onboardingFinish)
                .frame(width: 320, height: 360)
                .padding(.top, 44)
            VStack {
                HStack {
                    CustomText(
                        "제 과제 빵점 오픈을\n축하합니다!",
                        fontType: .title2Bold,
                        color: Color(.labelNormal)
                    )
                    .padding(
                        .top,
                        81
                    )
                    .padding(
                        .bottom,
                        36
                    )
                    
                    Spacer()
                }
                .padding(
                    .leading,
                    4
                )
                
                Spacer()
            }
            .padding(
                .horizontal,
                16
            )
        }
    }
}

#Preview {
    OnboardingView(
        viewModel: OnboardingViewModel(
            onboardingUseCase: DefaultOnboardingUseCase(
                repository: DefaultUserRepository()
            )
        ),
        isOnboardingComplete: .constant(false)
    )
}
