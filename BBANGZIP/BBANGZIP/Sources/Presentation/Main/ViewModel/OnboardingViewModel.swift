//
//  OnboardingViewModel.swift
//  BBANGZIP
//
//  Created by 조성민 on 1/25/25.
//

import SwiftUI

enum OnboardingStage {
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

final class OnboardingViewModel: ObservableObject {
    private let onboardingUseCase: OnboardingUseCase
    
    // 뷰 이동
    @Published var isOnboardingComplete: Bool = false
    
    // UseCase에 필요
    @Published var nickname: String = ""
    @Published var year: Int = 2025
    @Published var semester: Semester = .first
    @Published var subject: String = ""
    
    // 단계
    @Published var stage: OnboardingStage = .start
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
                subjectName: subject
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
        setNicknameAlertCase()
    }
    
    // state를 기준으로 nickname alert 업데이트
    func setNicknameAlertCase() {
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
        
        setNicknameAlertCase()
        validateNextButton()
    }
    
    // subject 변경시 호출
    func handleSubject(
        oldSubject: String,
        newSubject: String
    ) {
        if newSubject.count > 10 {
            subject = String(oldSubject.prefix(10))
        }
        if subject.isEmpty {
            subjectTextFieldState = .placeholder
        } else if subject.isValidSubject {
            subjectTextFieldState = .typing
        } else {
            subjectTextFieldState = .alert
        }
        
        setSubjectAlertCase()
        validateNextButton()
    }
    
    // state를 기준으로 subject alert 업데이트
    func setSubjectAlertCase() {
        switch subjectTextFieldState {
        case .defaultState, .placeholder, .alert:
            subjectTextFieldAlertCase = .alert
        default:
            subjectTextFieldAlertCase = .enable
        }
    }
    
    // focus가 들어왔을 때 기존의 state 기준으로 state와 alert 변경
    func setSubjectState(isSubjectFocused: Bool) {
        switch subjectTextFieldState {
        case .defaultState:
            subjectTextFieldState = isSubjectFocused ? .placeholder : .defaultState
        case .placeholder:
            subjectTextFieldState = isSubjectFocused ? .placeholder : .defaultState
        case .typing:
            subjectTextFieldState = isSubjectFocused ? .typing : .field
        case .alert:
            break
        case .field:
            subjectTextFieldState = isSubjectFocused ? .typing : .field
        }
        setSubjectAlertCase()
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
            if subjectTextFieldAlertCase == .alert {
                isNextButtonDisabled = true
            } else {
                isNextButtonDisabled = false
            }
        case .end:
            isNextButtonDisabled = false
        }
    }
}
