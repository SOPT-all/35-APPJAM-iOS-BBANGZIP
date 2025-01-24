//
//  OnboardingView.swift
//  BBANGZIP
//
//  Created by 김송희 on 1/20/25.
//  Copyright © 2025 com.bbangzip. All rights reserved.
//

import SwiftUI

enum NewOnboardingStage {
    case start
    case nickname
    case semester
    case subject
    case end
    
    var buttonTitle: String {
        switch self {
        case .start:
            "빵집 오픈하러 가기"
        case .end:
            "빵점 탈출하러 가기"
        default:
            "다음으로"
        }
    }
    
    var step: Step {
        switch self {
        case .start:
                .first
        case .nickname:
                .first
        case .semester:
                .second
        case .subject:
                .third
        case .end:
                .third
        }
    }
}

final class NewOnboardingViewModel: ObservableObject {
    private let onboardingUseCase: OnboardingUseCase
    
    // 뷰 이동
    @Published var isOnboardingComplete: Bool = false
    
    // UseCase에 필요
    @Published var nickname: String = ""
    @Published var year: Int = 2025
    @Published var semester: Semester = .first
    @Published var subjectName: String = ""
    
    // 단계
    @Published var stage: NewOnboardingStage = .start
    @Published var progressBarStep: Step = .first
    
    // TextField State
    @Published var nicknameTextFieldState: TextFieldState = .defaultState
    @Published var subjectTextFieldState: TextFieldState = .defaultState
    
    // TextField Alert Case
    @Published var nicknameTextFieldAlertCase: NicknameTextFieldAlertCase = .alert
    @Published var subjectTextFieldAlertCase: SubjectTextFieldAlertCase = .alert
    
    // NextButton Disable
    @Published var isNextButtonDisabled: Bool = false
    
    init(onboardingUseCase: OnboardingUseCase) {
        self.onboardingUseCase = onboardingUseCase
    }
    
    func onBoard() async {
        do {
            try await onboardingUseCase.execute(
                nickname: nickname,
                year: year,
                semester: semester.rawValue,
                subjectName: subjectName
            )
            isOnboardingComplete = true
        } catch {
            dump(error)
        }
    }
    
    @MainActor
    func goNextStage() async {
        switch stage {
        case .start:
            stage = .nickname
        case .nickname:
            stage = .semester
        case .semester:
            stage = .subject
        case .subject:
            stage = .end
        case .end:
            Task {
                await onBoard()
            }
        }
        validateNextButton()
        progressBarStep = stage.step
    }
    
    func goPrevStage() {
        switch stage {
        case .start:
            print("처음엔 뒤로 못 감")
            break
        case .nickname:
            stage = .start
        case .semester:
            stage = .nickname
        case .subject:
            stage = .semester
        case .end:
            stage = .subject
        }
        validateNextButton()
        progressBarStep = stage.step
    }
    
    // focus가 들어왔을 때 기존의 state 기준으로 state와 alert 변경
    func setNicknameState(isNicknameFocused: Bool) {
        switch nicknameTextFieldState {
        case .defaultState:
            nicknameTextFieldState = isNicknameFocused ? .placeholder : .defaultState
        case .placeholder:
            nicknameTextFieldState = isNicknameFocused ? .placeholder : .defaultState
        case .typing:
            nicknameTextFieldState = isNicknameFocused ? .typing : .field
        case .alert:
            break
        case .field:
            nicknameTextFieldState = isNicknameFocused ? .typing : .field
        }
        setAlertCase()
    }
    
    // state를 기준으로 alert 업데이트
    func setAlertCase() {
        switch nicknameTextFieldState {
        case .defaultState, .placeholder, .alert:
            nicknameTextFieldAlertCase = .alert
        default:
            nicknameTextFieldAlertCase = .enable
        }
    }
    
    // 닉네임 변경시 호출
    func handleNickname(
        oldNickname: String,
        newNickname: String
    ) {
        print(#function, "old: \(oldNickname) | new: \(newNickname)")
        // 문자열 입력 최대 차단
        if newNickname.count > 10 {
            nickname = String(oldNickname.prefix(10))
        }
        if nickname.isEmpty {
            nicknameTextFieldState = .placeholder
        } else if nickname.isValidNickname {
            nicknameTextFieldState = .typing
        } else {
            nicknameTextFieldState = .alert
        }
        
        setAlertCase()
        validateNextButton()
    }
    
    func handleSubject() {
        print("subject 로직")
        validateNextButton()
    }
    
    func validateNextButton() {
        switch stage {
        case .start:
            isNextButtonDisabled = false
        case .nickname:
            if nicknameTextFieldAlertCase == .alert {
                isNextButtonDisabled = true
            } else {
                isNextButtonDisabled = false
            }
        case .semester:
            if year == 2025 && semester == .first {
                isNextButtonDisabled = false
            } else {
                isNextButtonDisabled = true
            }
        case .subject:
            break
        case .end:
            isNextButtonDisabled = false
        }
    }
    
}

struct NewOnboardingView: View {
    @ObservedObject private var viewModel: NewOnboardingViewModel
    @Binding private var isOnboardingComplete: Bool
    
    // Focus
    @FocusState var isNicknameFocused: Bool
    @FocusState var isSubjectFocused: Bool
    
    init(
        viewModel: NewOnboardingViewModel,
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
                Text("A")
            case .end:
                backButton
                Text("A")
            }
            
            nextButton
        }
        .onChange(of: viewModel.isOnboardingComplete) { newValue in
            isOnboardingComplete = newValue
        }
        .onTapGesture {
//            viewModel.focusOff()
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
}


struct OnboardingView: View {
    @StateObject private var viewModel: OnboardingViewModel
    @FocusState private var isNicknameFocused: Bool
    @FocusState private var isSubjectFocused: Bool
    private let years = Array(2025...2028)
    @Binding private var isOnboardingComplete: Bool
    
    init(isOnboardingComplete: Binding<Bool>) {
        let repository = DefaultUserRepository()
        let useCase = DefaultOnboardingUseCase(repository: repository)
        _viewModel = StateObject(
            wrappedValue: OnboardingViewModel(
                onboardingUseCase: useCase
            )
        )
        _isOnboardingComplete = isOnboardingComplete
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
            .ignoresSafeArea(.keyboard)
            //            .onChange(of: viewModel.navigateToCustomTabView) { navigate in
            //                if navigate {
            //                    CustomTabView()
            //                }
            //            }
        }
        .onChange(of: viewModel.navigateToCustomTabView) { newValue in
            isOnboardingComplete = newValue
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
            .padding(.horizontal, 44)
            .padding(.bottom, 48)
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
    
    private var nextButton: some View {
        Button(
            "다음으로",
            action: viewModel.goNext
        )
        .buttonStyle(
            SolidIconButton(
                buttonImage: Image(.chevronRightThickSmall),
                (viewModel.currentState == .nameInput) ? viewModel.isNicknameValid
                : (viewModel.currentState == .subjectInput) ? viewModel.isSubjectValid
                : (viewModel.currentState == .semesterInput) ? viewModel.isSemesterValid
                : true
            )
        )
        .disabled(
            (viewModel.currentState == .nameInput) ? !viewModel.isNicknameValid
            : (viewModel.currentState == .subjectInput) ? !viewModel.isSubjectValid
            : (viewModel.currentState == .semesterInput) ? !viewModel.isSemesterValid
            : false
        )
        .padding(.horizontal, 20)
    }
    
    private var completeButton: some View {
        Button(
            "빵점 탈출하러 가기",
            action: {
                Task {
                    await viewModel.onboard()
                }
            }
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
                nameInputView
            } else if viewModel.currentState == .semesterInput {
                semesterInputView
            } else if viewModel.currentState == .subjectInput {
                subjectInputView
            }
        }
        .animation(.bouncy, value: viewModel.currentState)
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
            .padding(.top, 30)
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
                newText: newNickname,
                isNicknameFocused: isNicknameFocused
            )
        }
        .onChange(of: isNicknameFocused) { isNicknameFocused in
            viewModel.handleNicknameFocusChange(
                newText: viewModel.nickname,
                isNicknameFocused: isNicknameFocused
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
        .onChange(of: viewModel.year) { _ in
            viewModel.verifySemester()
        }
        .padding(.leading, -5)
        .padding(.trailing, -15)
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
            viewModel.verifySemester()
        }
        .padding(.leading, -15)
        .padding(.trailing, -5)
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
            .padding(.horizontal, 20)
        }
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
        VStack(spacing: 0) {
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
                newText: newSubject,
                isSubjectFocused: isSubjectFocused
            )
        }
        .onChange(of: isSubjectFocused) { isFocused in
            viewModel.handleSubjectFocusChange(
                newText: viewModel.subject,
                isSubjectFocused: isSubjectFocused
            )
        }
    }
}

#Preview {
    NewOnboardingView(
        viewModel: NewOnboardingViewModel(
            onboardingUseCase: DefaultOnboardingUseCase(
                repository: DefaultUserRepository()
            )
        ),
        isOnboardingComplete: .constant(false)
    )
}
