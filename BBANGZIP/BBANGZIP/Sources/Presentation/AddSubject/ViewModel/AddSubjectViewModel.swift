//
//  AddSubjectViewModel.swift
//  BBANGZIP
//
//  Created by 최유빈 on 1/19/25.
//  Copyright © 2025 com.bbangzip. All rights reserved.
//

import SwiftUI

class AddSubjectViewModel: ObservableObject {
    private let addSubjectUseCase: AddSubjectUseCase
    private let parentViewModel: SubjectManageViewModel
    @Published var shouldDismiss: Bool = false
    @Published var subject: String
    @Published var subjectAnnounceState: SubjectTextFieldAlertCase?
    @Published var subjectState: TextFieldState
    @Published var isSubjectFocused: Bool = false
    @Published var isSubjectValid: Bool = false
    @Published var isEnabled: Bool
    @Published var toast: Toast?
    
    init(
        addSubjectUseCase: AddSubjectUseCase,
        parentViewModel: SubjectManageViewModel,
        subject: String = "",
        subjectAnnounceState: SubjectTextFieldAlertCase? = .alert,
        subjectState: TextFieldState = .defaultState,
        isEnabled: Bool = false
    ) {
        self.addSubjectUseCase = addSubjectUseCase
        self.parentViewModel = parentViewModel
        self.subject = subject
        self.subjectAnnounceState = subjectAnnounceState
        self.subjectState = subjectState
        self.isEnabled = isEnabled
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
        
        isEnabled = subjectAnnounceState == .enable
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
    func addSubject(subjectName: String) async {
        // TODO: 과목 추가, 과목 중복 비교 로직 / 토스트 메시지 노출 로직 구현 필요
        do {
            let completeResult: () = try await addSubjectUseCase.execute(
                year: 2025,
                semester: .first,
                subjectName: subjectName
            )
            
            parentViewModel.toast = Toast(
                "과목 추가 완료! 공부를 시작해 볼까요?",
                startFrom: 20
            )
            
            await parentViewModel.fetchData()
            
            self.shouldDismiss = true
            
        } catch {
            toast = Toast(
                "이미 등록된 과목이에요",
                startFrom: 76
            )
            
            dump(error)
            print(error)
        }
    }
    
}
