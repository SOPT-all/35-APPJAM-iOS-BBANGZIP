//
//  OnboardingView.swift
//  BBANGZIP
//
//  Created by 김송희 on 1/20/25.
//  Copyright © 2025 com.bbangzip. All rights reserved.
//

import SwiftUI

struct OnboardingView: View {
    @StateObject private var viewModel: OnboardingViewModel
    
    @State var oldNickname: String = ""
    @State var oldSubject: String = ""
    @FocusState private var isNicknameFocused: Bool
    @FocusState private var isSubjectFocused: Bool
    @State private var isPickerPresented: Bool = false
    private let years = Array(2025...2028)
    
    init(
        viewModel: OnboardingViewModel = OnboardingViewModel()
    ) {
        _viewModel = StateObject(wrappedValue: viewModel)
    }
    
    var body: some View {
        NavigationStack {
            VStack(spacing: 0) {
                switch viewModel.currentState {
                case .start:
                    OnboardingStartView()
                    
                    startButton
                    
                case .complete:
                    backButton
                    
                    OnboardingCompleteView()
                    
                    completeButton
                default:
                    backButton
                    
                    progressBar
                    
                    inputView
                    
                    nextButton
                }
            }
        }
        .ignoresSafeArea(.keyboard)
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
    
    private var startButton: some View {
        Button(
            "빵집 오픈하러 가기",
            action: viewModel.goNext
        )
        .buttonStyle(
            SolidIconButton(
                buttonImage: Image(.chevronRightThickSmall)
            )
        )
        .padding(.horizontal, 20)
    }
    
    // TODO: 입력값 valid 여부에 따라 버튼 disable 처리 필요
    private var nextButton: some View {
        Button(
            "다음으로",
            action: viewModel.goNext
        )
        .buttonStyle(
            SolidIconButton(
                buttonImage: Image(.chevronRightThickSmall),
                viewModel.isNicknameValid
            )
        )
        .disabled(!viewModel.isNicknameValid)
        .padding(.horizontal, 20)
    }
    
    private var completeButton: some View {
        Button(
            "빵점 탈출하러 가기",
            action: viewModel.goNext
        )
        .buttonStyle(
            SolidIconButton(
                buttonImage: Image(.chevronRightThickSmall)
            )
        )
        .padding(.horizontal, 20)
    }
    
    private var inputView: some View {
        ZStack {
            if viewModel.currentState == .nameInput {
//                NameInputView(
//                    nickname: $viewModel.nickname
//                )
                nameInputView
                .transition(.move(edge: .leading))
            } else if viewModel.currentState == .semesterInput {
                semesterInputView                .transition(
                    .asymmetric(
                        insertion: .move(edge: viewModel.isForward ? .trailing : .leading),
                        removal: .move(edge: viewModel.isForward ? .leading : .trailing)
                    )
                )
            } else if viewModel.currentState == .subjectInput {
                subjectInputView
                .transition(.move(edge: .trailing))
            }
        }
        .animation(
            .easeInOut,
            value: viewModel.currentState
        )
    }
    
    private var nameInputView: some View {
        VStack(spacing: 0) {
            VStack(spacing: 32) {
                mainDescription
                
                nicknameTextField
                
                Spacer()
            }
            .padding(
                .horizontal,
                20
            )
        }
    }
    
    private var mainDescription: some View {
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
                state: viewModel.nicknameState,
                alertText: viewModel.nicknameAnnounceState
            )
        )
        .onChange(of: viewModel.nickname) { newNickname in
            if newNickname.count > 10 {
                viewModel.nickname = String(newNickname.prefix(10))
            }
            
            viewModel.verifyNickname(
                oldText: oldNickname,
                newText: newNickname,
                isNicknameFocused: isNicknameFocused
            )
            
            oldNickname = viewModel.nickname
        }
        .onChange(of: isNicknameFocused) { isNicknameFocused in
            viewModel.handleNicknameFocusChange(
                isNicknameFocused: isNicknameFocused,
                text: viewModel.nickname
            )
        }
    }

    private var semesterInputView: some View {
        VStack(spacing: 0) {
            VStack(spacing: 0) {
                subjectHeaderDescription
                
                subjectMainDescription
                
                HStack(spacing: 0) {
                    yearPicker
                    
                    semesterPicker
                }
                
                Spacer()
            }
            .padding(
                .horizontal,
                20
            )
        }
    }
    
    private var subjectHeaderDescription: some View {
        HStack {
            CustomText(
                "\(viewModel.nickname) 사장님, 안녕하세요!",
                fontType: .body2Bold,
                color: Color(.labelAlternative)
            )
            
            Spacer()
        }
        .padding(
            .bottom,
            8
        )
    }
    
    private var subjectMainDescription: some View {
        HStack {
            CustomText(
                "현재 재학 중인\n학기를 알려주세요",
                fontType: .title2Bold,
                color: Color(.labelNormal)
            )
            
            Spacer()
        }
        .padding(
            .bottom,
            32
        )
    }
    
    private var yearPicker: some View {
        Picker(
            "Year",
            selection: $viewModel.year
        ) {
            ForEach(
                years,
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
        .padding(
            .leading,
            -15
        )
        .padding(
            .trailing,
            -5
        )
        .clipped()
    }
    
    private var subjectInputView: some View {
        VStack(spacing: 0) {
            VStack(spacing: 0) {
                subjectHeaderDescription
                
                subjectMainDescription
                
                subjectTextField
                
                Spacer()
            }
            .padding(
                .horizontal,
                20
            )
        }
    }
    
    private var SubjectHeaderDescription: some View {
        HStack(spacing: 0) {
            CustomText(
                "\(viewModel.year)년 \(viewModel.semester.rawValue)에 재학 중이시네요!",
                fontType: .body2Bold,
                color: Color(.labelAlternative)
            )
            
            Spacer()
        }
        .padding(
            .bottom,
            8
        )
    }
    
    private var SubjectMainDescription: some View {
        VStack(spacing: 0) {
            HStack(spacing: 0) {
                CustomText(
                    "수강하는 과목 중\n한 가지만 먼저 입력해 볼까요?",
                    fontType: .title2Bold,
                    color: Color(.labelNormal)
                )
                Spacer()
            }
            .padding(
                .bottom,
                33
            )
        }
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
                state: viewModel.subjectState,
                alertText: viewModel.subjectAnnounceState
            )
        )
        .onChange(of: viewModel.subject) { newSubject in
            if newSubject.count > 10 {
                viewModel.subject = String(newSubject.prefix(10))
            }
            
            viewModel.verifySubject(
                oldText: oldSubject,
                newText: newSubject,
                isSubjectFocused: isSubjectFocused
            )
            
            oldSubject = viewModel.subject
        }
        .onChange(of: isSubjectFocused) { isFocused in
            viewModel.handleSubjectFocusChange(
                isSubjectFocused: isSubjectFocused,
                text: viewModel.subject
            )
        }
    }
}

#Preview {
    OnboardingView()
}
